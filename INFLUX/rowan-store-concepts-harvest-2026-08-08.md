---
source: "~/src/rowan/ read at source (HEAD 0ecf61aa39e24165a0418409520d54ff8d4c07b2, 2026-07-09) by a read-only explorer, steward-directed"
gathered: 2026-08-08
status: gathered — explorer report verbatim below its own coverage table; [READ]/[STRUCT] register marks are the agent's own; per-claim file:line cites resolve against the pinned commit
why_included: >
  Steward: rowan holds "a pretty well-developed intuition of stores and store
  composition — including stores that consist of (for example) flat directories
  — basically underlying understanding and precursor findings for the udon
  store concept." Feeds form-luss. Companion to
  rowan-archema-harvest-2026-08-08.md (which covered the schema/evolution
  cluster from provenanced copies; this one went to the source).
---

# Rowan store-concept harvest (explorer report, verbatim)

> [!warning] Corrected by the steward map (2026-08-08, same day — see `rowan-store-map-steward-2026-08-08.md`, which supersedes this report where they disagree). Two load-bearing corrections: **(1)** §6/§10's "unification still in-progress at HEAD, bifurcation live" is wrong — `MultiStore` was **deleted** and folded into `StoreComposition` (ADR-001 Step 6 executed); this report characterized the deleted class from its stale generated doc (`docs/sys/multi-store.md`) without verifying the file existed — the characterize-vs-read failure, live specimen. The atomicity *reasoning* quoted in §6 still stands (it survives in README/ISSUES/open-questions), but attribute it to the composition model, not to a live MultiStore class. **(2)** §10 delta 1's "the flat-directories plurality isn't there" overstates — not *implemented*, but a rich **conceptualized/aspirational store layer exists** (Redis, Elasticsearch, field-level compliance routing, S3/ClickHouse simulation scenarios, ISSUES' target-store queries), which for demand-mapping is exactly the layer that matters; this report searched for directory-*layout* vocabulary and missed store-*type* plurality. The close reads (§1 ADR-001, §3–§5 adapters, §8 testing plan) remain the report's value.

**Repo:** `/Users/josephwecker-v2/src/rowan` (gem internals: `archema`)  
**HEAD pin:** `0ecf61aa39e24165a0418409520d54ff8d4c07b2` — Thu Jul 9 2026

**Verdict up front:** Joseph's memory is right about *store composition* — that intuition is deep, argued, and has a real ADR. It is **partly wrong about "stores that consist of flat directories, etc. etc."** as a *plural family of directory shapes*. Rowan has exactly **one** directory-shaped store (YamlFrontmatter), and it is a **single flat directory, non-recursive, one-file-per-record, filename = primary key**. There is no nesting, no layout ladder, no directory-as-table taxonomy anywhere in the repo (searched explicitly; zero hits outside quotes about Ash's migration-snapshot folders). So: the composition intuition is the prior art; the layout-ladder intuition is *not* in rowan, and LUSS would be extending rather than porting.

**[READ]** = the agent read the text; **[STRUCT]** = characterized from structure/names.

## 1. The conceptual core: ADR-001 Store Composition [READ, full]

`docs/dev/adr-001-store-composition.md` (597 lines) — the single most LUSS-relevant document in the repo.

**The disambiguation move** (`:5-58`): rowan splits "multi-store" into **three genuinely different concepts**:

1. **Heterogeneous Resource Reconciliation** (`:9-25`) — different *resources* on different adapters that must relate. Named challenges: "No true SQL JOINs across adapters"; "Transaction semantics differ (PostgreSQL has ACID, YAML files don't)."
2. **Combinatory Store** (`:29-42`) — one logical store that *routes* to physical adapters by operation/context. "The Resource doesn't know about the routing."
3. **Multi-Store / Concurrent Stores** (`:46-58`) — one resource writing to several adapters *simultaneously*, each for a different purpose.

Unification (`:60-78`): **2 and 3 collapse into one composable model; 1 stays a separate concern.** Core insight verbatim (`:66`): "All store configurations are **ordered compositions** of entries," where `StoreEntry = (role, mode, adapter_or_name, params, resolver)`, and (`:76`) "A 'simple store' is a composition of one entry. A 'profile' is a composition of multiple entries. Composition is merging ordered sets, with later entries overriding earlier ones on role+mode collision."

**LUSS-relevant commitments in ADR-001:**

- **Shared adapter instances keyed by registered name** (`:84-109`). "Resources reference stores by name, not by instantiating adapters directly."
- **`:readwrite` is ONE entry, not sugar for two** (`:437-455`): "A Memory adapter must be a single coherent object. If `:readwrite` expanded to two entries, you'd have two Memory instances that need synchronization—defeating the purpose." This **directly contradicts** `docs/msc/store-api-clarification.md:80-91` (argues the opposite) — and the shipped code sides with the clarification doc: `lib/archema/stores.rb` `VALID_MODES = [:read, :write]`, constructor raises "`:readwrite` is DSL sugar, not a storage mode". **An unresolved, documented, live tension in rowan's own model** — a known fork to carry into LUSS.
- **Demotion semantics** (`:443-455`): adding `:read` to a role holding `:readwrite` *demotes* the incumbent to `:write` rather than erroring; a subsequent explicit `:write` errors. Ordered-override with a typed collision rule.
- **Adapter config vs operation params** (`:479-503`): adapter config (connection, pool) lives at registration, shared; operation params (`table:`, `soft_delete:`) live per-entry. `User` and `Post` share one `:main_db` instance with `table: :users` / `table: :posts` per-entry.
- **Resolver levels; Level 3 scoped out** (`:505-560`): (1) entry-level param computation, (2) entry-level adapter routing, (3) composition-level runtime mutation. Decision: 1–2 supported; 3 out — "Levels 1-2 cover all practical needs. Level 3 is speculative complexity with no concrete use case." Compositions must be predefined; dynamic routing selects *between* predefined compositions; resolvers return a Symbol or params-Hash, never a new composition.
- **Roles are arbitrary symbols; behavior inferred from role *prefix*** (`:390-412`, ISSUE-053): `primary*`→`:write_primary`, `cache*`→`:read_cache`, `projection*`→`:write_fanout`, `event*`→`:append_events`; `behavior:` overrides. Implemented at `lib/archema/stores.rb:84-97`.
- **Open questions still open** (`:340-388`, `:562-570`): multiple read stores per role; write ordering/failure semantics; params flow; resolver context population; and **"Default Table Inference"** — when `table:` is nil, inference from resource class name: at *composition* time or *operation* time? Direct LUSS analogue: **when does a name become a path.**

## 2. Where "when do references resolve" actually lives

Three resolution moments named: **registration time** (`Archema.def_store` → registry, `lib/archema/stores.rb:479,483`), **composition/merge time** (replacement by `[role, mode]` key, `:124,:261`; compositions immutable/frozen `:179-183`), **operation time** (`StoreEntry#resolve(resource, operation, context)` `:111-121`, dispatching on block arity).

And a fourth, the sleeper finding: **composition history is a first-class recorded artifact.** `CompositionHistoryEntry` (`lib/archema/stores.rb:144`) records `(action, key, entry, previous_entry, source)` where `source` is a human string like `"def_store :standard (merged :base)"` or `"Resource User (merged :standard)"` (`:552-558,:594-600`). `#debug_report` renders final state *plus* derivation (`docs/usr/09-stores.md:~330-350`). **Provenance-carrying configuration resolution** — a resolved composition knows which declaration each entry came from.

## 3. The adapter contract: what's store-independent

`lib/archema/store_adapter.rb` (154 lines) — the whole promised surface is small: required `create/read/update/destroy` (Result-returning); `get(id)` `:88` provided *generically* as `Query.filter(pk => id).limit(1)` then `read` — **identity lookup is defined in terms of query, not location**; `bulk_create` naive; `transaction` `:128` — **default is a no-op that just calls the block** — and `supports_transactions? = false` `:139`, "used by `require_atomic?` enforcement to ensure actions that require atomicity are actually getting real transaction guarantees." **Transactions are a no-op you can call anywhere, and a separate predicate tells you whether the no-op was real — atomicity is advisory-by-introspection.**

Everything else — filtering, sorting, pagination, defaults, coercion, upcasting — is **per-adapter and duplicated** (YamlFrontmatter privately reimplements all of it; shared `FilterMatcher` mixin only). **The contract promises CRUD-returning-Result; it does not promise query semantics** — and `docs/dev/plan-systematic-multistore-testing.md:60-70` names that as a known defect.

## 4. The directory-shaped store, precisely

`lib/archema/store_adapters/yaml_frontmatter.rb` (594 lines) — rowan's only file-layout store; layout rules in ~40 lines:

- Options (`:77-90`): `directory:`, `extension:` (default `.md`), `body_attribute:`, `filename_attribute:`, `schema_field:` (default `:_schema`), `cache:`.
- `path_for` `:241-252`: filename = `filename_attribute` value if set, **else the primary key**; `File.join(directory, "#{sanitized}#{ext}")`. **One directory, no sub-paths.**
- `sanitize_filename` `:263`: path separators destroyed (`/\:*?"<>|` → `_`), `..` → `_`. **An identity can never express hierarchy; a key containing `/` becomes `_` silently.**
- Enumeration `:218`: **non-recursive glob, extension-scoped** — the directory *is* the table; membership = "matches `*.ext` at depth 1"; other extensions invisible (how two resources co-locate in one directory).
- `count` with no filters = `Dir.glob(...).count` — cardinality without parsing.
- Cache: path → `{mtime:, record:}`; `invalidate_all_caches` exists "useful when files change externally" — the adapter concedes it is not the only writer.
- Creation: exists-check-then-write under a **process** mutex; identity uniqueness enforced by *filesystem name collision*, single-process only.

**Schema/dialect binding, in-file:** `extract_schema_version` `:357-372` *deletes* `_schema` from parsed frontmatter, parses `"type/version"`; `upcast_if_needed` `:376-386` calls `resource.upcast_data(...)`; `apply_attribute_renames` applies `was:`. **Each document self-declares its dialect inline; the store strips the declaration on read; the schema layer migrates the record in memory at load time. Read-time upcast, no write-back** — a shipped answer to "how do documents carry their own schema binding with no central catalog."

`body_attribute` (`:38-48`): **one designated attribute is not a field but *the file's body*** — a record has a structured part and one distinguished unstructured part; the file format is the encoding of that split.

## 5. The one-file-many-records store

`lib/archema/store_adapters/jsonl.rb` (679 lines), candid docstring `:10-80`: appendable/streamable/grep-and-tail-able/git-line-diffable; **update/destroy are *appends*** ("append new lines with the same ID; reads return the latest version by scanning from end" `:30-31` — contradicting `docs/usr/09-stores.md:~195` "update/destroy not supported"; doc drift, code comment newer); in-memory PK index, stale on external edit → `reload!`; **"Multi-process: No built-in coordination; use external locking or dedicate one process as writer"** (`:42-50`), fsync opt-in; BLAKE3 hash chaining with `verify_chain!` (`:33-40`).

The YAML/JSONL pair is rowan's real layout axis: **file-per-record in a flat directory** (name-as-identity, per-record mtime cache, git-per-document diffs, O(1) delete; full-scan queries, no ordering) vs **many-records-in-one-file** (append-cheap, natural total order, tamper-evidence, unix ergonomics; needs an index, no in-place mutation, single-writer discipline). Nobody wrote the trade-off as prose; it's legible from the two adapters.

## 6. Multi-store atomicity — the reasoning

`docs/sys/multi-store.md` (generated from `lib/archema/multi_store.rb`). Routing (`:64-69`): read/get = cache → projection → primary, first hit wins; count prefers projection; create/update/destroy = primary → event → projections, **primary must succeed, others best-effort**.

**"Atomicity Limitations (ISSUE-036)"** (`:70-89`), verbatim load-bearing parts: "Multi-store writes are NOT atomic… no shared transaction boundary"; best_effort "will log failures but continue, potentially leaving projections stale"; "no automatic rollback of the primary write." Mitigations: "**Use event store as source of truth and rebuild projections on failure**; idempotent replay via `rebuild_projection`; for critical consistency use a single transactional store; monitor secondary write failures." Closer: "the `:saga` consistency mode (planned) will provide compensation-based eventual consistency, but **true ACID guarantees across heterogeneous stores are architecturally impossible without a distributed transaction coordinator.**"

`CONSISTENCY_MODES = [:best_effort, :strict, :saga]` (`:151-166`, default `:best_effort`): best_effort logs-and-continues on secondary failure; strict re-raises and aborts; saga = compensating transaction, **not implemented**. So: **non-atomic by design, impossibility argued not asserted, a per-composition knob for how loud failure is, event-log-replay as the recovery story instead of rollback.** Also: `MultiStore` deliberately does *not* inherit `StoreAdapter` (a composite that can't be a member of the type it composes); ADR-001 plans to delete the 914-line class and fold orchestration into `StoreComposition` — **still in-progress at HEAD**, the bifurcation live.

## 7. Cross-store relationships

`lib/archema/preloader.rb`: collect source PKs → one batch `filter(:fk, :in, pks)` per relationship → index → assign → recurse. ADR-001 `:23`: "Not true JOINs, but functional." Named limits (`:36-41`): no filtering/sorting/pagination on relationships; `IN` degrades past ~1000; nested preloads multiply queries. `grep "cross-store\|cross-adapter" lib/` → **nothing**: the preloader has no adapter-awareness — **cross-store joining works because the preloader only ever speaks `Query`, and every adapter must answer `read(query)`. Heterogeneity is survivable exactly to the extent that the query interface is store-independent** — which loops back to §3, where query semantics are the least-specified part of the contract.

## 8. Off-list — the best of the harvest

**`docs/dev/plan-systematic-multistore-testing.md`** (`:1-70` READ) — a methodological argument about earning the right not to test a combinatorial space: 5 store types × 3 composition sizes × 7 field types × 5 operations × 4 evolution kinds × 3 relationship kinds × 2 spans = **12,600 cases**; "We cannot test everything." Then: "**Permutation testing is not the end goal—it's a means to prove that the abstractions are sound.**" Three propositions that, once proven, collapse the matrix: (1) adapter contract sound; (2) composition mechanics correct over any conforming adapters; (3) **serialization symmetric** ("what goes into any adapter comes out unchanged modulo expected transformations like `was:` upcasting"). "When these three are proven… 'Does this adapter pass the contract? Then it works.'" Followed by "**We're not there yet**" — permutation tests as a *discovery instrument* for where adapters diverge. For LUSS: a ready-made shape for what a store-conformance spec must promise, and the honest failure mode — **you can't reason compositionally while serialization symmetry doesn't hold.**

**`test/archema/specifications/heterogeneous_multistore_spec_test.rb:8-22`** [READ]: "Archema's key differentiator is cross-store composition… This is NOT tested elsewhere." Motivating shapes: memory-primary + JSONL-event ("fast in-memory reads with durable event log") and memory-primary + YAML-frontmatter-projection (`:79`) — "fast queries against memory, **human-readable files for git**." The second is the LUSS shape: *the filesystem as a projection chosen for human and VCS legibility rather than query performance.*

**`docs/msc/store-composition-spike.rb`** (369 lines) [STRUCT, not read]: the executable spike ADR-001's addendum derived from — the model as running code.

## 9. Coverage table (explorer's own register)

READ in full: adr-001-store-composition.md (597L, the primary source); docs/sys/stores.md; docs/sys/store-adapter.md; docs/sys/store-adapters/yaml-frontmatter.md; docs/usr/09-stores.md (best plain-language "what a store is"). READ partial: docs/sys/multi-store.md `:1-170`; store-api-clarification.md `:1-180`; plan-systematic-multistore-testing.md `:1-70`; multi-store-plan.md `:1-60`; yaml_frontmatter.rb `:1-120,:225-400`; jsonl.rb `:1-90`. Not read: multi_store.rb directly (characterized via its generated doc); memory/sequel adapters + their generated docs; store-composition-spike.rb; docs/usr/11-multi-store.md; docs/msc/plan-memory-store-versioning.md. No store ADR other than ADR-001; docs/exp/ has nothing store-shaped.

## 10. Honest deltas for the paths corpus

1. **The "flat directories, etc. etc." plurality isn't there.** One directory adapter, one flat non-recursive layout, filename = PK with separators sanitized away. LUSS's layout ladder has no rowan precedent — it has a rowan *floor* (depth-1, extension-scoped globbing) to build up from.
2. **Rowan's store concept is about *routing and roles*, not *layout*.** "Store" = a named, ordered, immutable composition of (role, mode, adapter, params, resolver) entries with merge-override semantics. The physical shape of bytes is the adapter's private business; nothing above the adapter knows a path exists. Clean separation — and the reason the layout intuition never developed.
3. **Two live internal contradictions to inherit as questions:** `:readwrite`-as-one-entry vs as-sugar-for-two; JSONL update-as-append vs update-unsupported.
4. **Atomicity is the strongest finding and holds up:** non-atomic by design, argued from impossibility, mitigated by event-log-as-truth + idempotent projection rebuild, with `supports_transactions?` as the introspectable escape hatch.
5. **The unexpectedly LUSS-shaped leads:** composition-history-with-source-attribution (resolution that records its own derivation), and `_schema: "type/version"` inline dialect declaration stripped on read and handed to a read-time upcaster.
