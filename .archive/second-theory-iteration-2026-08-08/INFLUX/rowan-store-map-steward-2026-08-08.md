---
source: "~/src/rowan — store-types + multi-store map, delivered by Joseph in-session 2026-08-08 (produced repo-side; supersedes the explorer harvest where they disagree)"
gathered: 2026-08-08
status: gathered verbatim — the authoritative map of this territory; the explorer report (rowan-store-concepts-harvest-2026-08-08.md) remains for its close reads of ADR-001/adapters but carries a corrections banner pointing here
why_included: >
  Corrects the explorer on two load-bearing points: (1) MultiStore was DELETED
  and folded into StoreComposition (ADR-001 Step 6 executed; stale pointers in
  KEY_FILES.md and generated docs/sys/multi-store.md) — the explorer reported
  the unification as still in-progress; (2) the "flat directories, etc. etc."
  plurality DOES exist — as a conceptualized/aspirational layer (Redis, ES,
  field-level compliance routing, S3/ClickHouse simulation scenarios), which
  for demand-mapping is exactly the layer that matters. Also adds the pointer
  index (open-questions §Multi-Store, ISSUES items, path-centric-query-dsl,
  the 2025-12-18 consciousness-infra reflections) the explorer never surfaced.
---

# Rowan store map (steward-delivered, verbatim)

## 1. Implemented store adapters (4)

The only concrete StoreAdapter subclasses. Factory wiring: `lib/archema/resource/dsl.rb` (`build_single_layer`).

| Adapter | Path | Aliases | Purpose |
|---|---|---|---|
| Memory | lib/archema/store_adapters/memory.rb | :memory | Thread-safe in-process hash; tests/prototyping; no real txs |
| Sequel | lib/archema/store_adapters/sequel.rb | :sequel, :postgres, :postgresql, :sqlite | Production SQL (PostgreSQL + SQLite; MySQL in docs) |
| YAML Frontmatter | lib/archema/store_adapters/yaml_frontmatter.rb | :yaml_frontmatter, :yaml, :frontmatter | Git-friendly files (YAML metadata + optional Markdown body) |
| JSONL | lib/archema/store_adapters/jsonl.rb | :jsonl, :json_lines | Append-only event/audit logs; optional hash-chaining |

Base / composition machinery (not backends): `StoreAdapter` (lib/archema/store_adapter.rb, abstract CRUD contract); `StoreEntry` / `StoreComposition` / `Archema::Stores` / DSLs (lib/archema/stores.rb, registry + multi-store orchestration); `FilterMatcher` (lib/archema/filter_matcher.rb, shared filter logic for Memory / YAML / JSONL).

Evolution of naming/architecture:

- Early term: Data Layer → renamed to Store / StoreAdapter (docs/msc/data-layer-removal-plan.md, executed 2025-12-12).
- Early orchestrator: MultiStore (~914 lines) → **deleted and folded into StoreComposition** (ADR-001 Step 6; see MAP.md, CHANGELOG.md).
- Stale pointers still exist: KEY_FILES.md still lists lib/archema/multi_store.rb; generated docs/sys/multi-store.md still describes the deleted class.

Generated per-adapter sysdocs: docs/sys/store-adapters/{memory,sequel,yaml-frontmatter,jsonl}.md.

## 2. Composition roles (not separate adapters)

Composition is role + mode + adapter. Default behaviors inferred from role prefixes (lib/archema/stores.rb):

| Role family | Inferred behavior | Typical use |
|---|---|---|
| primary* | :write_primary | Source of truth |
| event* | :append_events | Audit / event log |
| projection* | :write_fanout | Derived read views |
| cache* | :read_cache | Read-first cache; invalidate on write |

Convenience DSL: read_store, write_store, event_store, projection_store, cache_store (ADR-001 / LEXICON.md).

Default routing (README + old MultiStore docs, still the intended model): read/get = cache → projection → primary; count = projection → primary; create/update/destroy = primary → event → projections, cache invalidate.

## 3. Conceptualized / aspirational stores (not implemented)

Vision, simulation context, open issues, early research — no adapter code:

| Name | Where it appears | Status |
|---|---|---|
| Redis (cache) | docs/VISION-drafts.md; ADR-001 example `cache_store :redis_cache`; test/simulation/archema_multistore_context.md; role name cache_redis in tests | Conceptual; Memory often stands in as :cache |
| Elasticsearch (search index) | VISION-drafts.md; path-centric query notes; multistore simulation context | Conceptual |
| Search index / geospatial (named secondary stores) | ISSUES.md (from_store / target-store queries) | Desired API; hardcoded routing only |
| MongoDB, HTTP/API, CSV | Early ROM comparison docs under docs/exp/ | Ecosystem reference, not Archema designs |
| ClickHouse, S3, blockchain-anchored logs, vector embeddings | LLM simulation scenarios under test/simulation/scenarios/ | Scenario fiction for stress-testing multi-store |
| Compliance vault / field-level store routing | ISSUES.md (fields only to certain stores) | Open design gap |
| Read replica / tenant sharding | ADR-001 "combinatory store" — dynamic resolvers over existing adapters, not new adapter types | Pattern designed; resolver infrastructure exists |

Postgres/SQLite are not separate adapters; both are Sequel backends (aliases + connection config).

## 4. The three multi-store perspectives (canonical model)

Authoritative design: docs/dev/adr-001-store-composition.md.

| # | Name | Meaning |
|---|---|---|
| 1 | Heterogeneous resource reconciliation | Different Resources, different adapters (User in PG ↔ AgentCard in YAML). Preloader batched loads, not SQL JOINs. |
| 2 | Combinatory store | One logical store, dynamic routing (replica vs primary, tenant shards) via resolvers. |
| 3 | Multi-store (concurrent) | One Resource writes/reads several adapters at once (primary + event + projection + cache). |

2 + 3 unified as ordered compositions of StoreEntries. Perspective 1 stays cross-adapter relationship coordination. Clarification/spike lineage: docs/msc/store-api-clarification.md; docs/msc/store-composition-spike.rb; docs/msc/multi-store-plan.md (early plan while MultiStore still existed).

## 5. Pointer index: multi-store / heterogeneous / composition

**Architecture & decisions:** docs/dev/adr-001-store-composition.md (canonical three-perspective model, DSL, registry, shared instances) · docs/msc/store-api-clarification.md (adapter vs composition vs orchestrator; "composition is the orchestrator") · docs/msc/multi-store-plan.md (original plan: roles, phases, consistency) · docs/msc/store-composition-spike.rb (exploratory spike) · docs/msc/data-layer-removal-plan.md (DataLayer → StoreAdapter rename) · docs/dev/adr-003-document-schema-first.md (feeds multi-store evolution differences) · docs/dev/plan-safe-rdbms-evolution.md (multi-store sync as consequence of resource-as-truth) · docs/dev/plan-systematic-multistore-testing.md (matrix: adapters × roles × relationships × evolution) · **docs/dev/open-questions.md §Multi-Store** (filter mapping, staleness, failure recovery, ops guidance) · LEXICON.md (StoreAdapter, composition, def_store, roles, heterogeneous reconciliation) · MAP.md Track 2 (adapter list, composition status, migration patterns) · README.md (composition bullets; routing table; atomicity warning) · CLAUDE.md (three-worlds + cross-store summary) · docs/VISION-drafts.md (simplified multi-store UX; elasticsearch/redis) · **ISSUES.md** (mode not enforced; target-store queries; field-level routing; multistore testing, ISSUE-050 etc.)

**User / system docs:** docs/usr/09-stores.md (adapters + composition axes) · docs/usr/11-multi-store.md (multi-store + event sourcing guide; older dual-Resource patterns mixed with the composition model) · docs/sys/stores.md · docs/sys/store-adapter.md · docs/sys/multi-store.md (**stale** — generated from the deleted MultiStore; routing table roughly accurate for StoreComposition, class name not) · docs/sys/store-adapters/*.

**Implementation:** lib/archema/stores.rb (StoreEntry, behaviors, StoreComposition CRUD routing, registry, def_store DSL) · lib/archema/resource/dsl.rb (store / stores / multi_store? / adapter factory) · **lib/archema/batch.rb** (transaction handling when store is a composition) · **lib/archema/schema/operations.rb** (sync/migrate across SQL-backed composition entries) · lib/archema/preloader.rb (cross-resource/cross-adapter batch loading — perspective 1).

**Tests & simulation:** test/archema/multi_store_test.rb · stores_test.rb · specifications/multistore_spec_test.rb (role routing) · specifications/heterogeneous_multistore_spec_test.rb (Sequel+YAML+JSONL+Memory incl. PG) · specifications/multistore_migration_spec_test.rb (schema evolution across multi-store) · specifications/multi_adapter_spec_test.rb (same contracts across adapters) · test/support/multi_adapter_test.rb · test/simulation/archema_multistore_context.md (LLM context for scenario generation) · test/simulation/scenarios/* (narrative multi-store "dream" scenarios — Redis, ES, S3, etc.).

**Exploratory / reflections:** docs/exp/path-centric-query-dsl.md (multi-store resource examples; ES vs PG full-text) · docs/exp/2025-12-03-modern-ruby-*.md (early storage-agnostic vision; ROM comparison: HTTP, YAML, CSV, Mongo, ES) · docs/exp/2025-12-03-schema-migration-and-versioning-in-ruby-domain-modeling.md (heterogeneous backend migration gap) · **docs/msc/reflections/2025-12-18-*.md (why multi-store matters for consciousness infra — CHRONICA + projections)** · docs/msc/plan-memory-store-versioning.md.

## 6. Mental model (compressed)

```
Resource
  └── StoreComposition  (always; even single-store)
        └── StoreEntry[]  (role + mode + behavior + adapter/name + resolver)
              └── StoreAdapter instance
                    ├── Memory
                    ├── Sequel  → PostgreSQL | SQLite
                    ├── YamlFrontmatter
                    └── Jsonl
```

Heterogeneous mixing happens at three layers: (1) within one Resource — composition of multiple adapters/roles; (2) across Resources — preloader, no cross-store SQL FK/JOIN; (3) dynamic routing — same role, different physical targets via resolvers (replica/tenant), designed in ADR-001.

Hard limit (documented everywhere): multi-store writes are not atomic across heterogeneous backends (ISSUE-036 / open questions #16). Recovery story is event-as-truth + rebuild_projection!.

## 7. Doc hygiene notes

- KEY_FILES.md still points at deleted multi_store.rb.
- docs/sys/multi-store.md is generated from that deleted file — routing table still roughly accurate for StoreComposition, class name not.
- docs/usr/11-multi-store.md mixes older dual-Resource patterns with the ADR-001 composition model; both are "multi-store," different shapes.

Offer on the table (repo-side): a single living docs/dev/ inventory (adapter matrix + composition axes + open gaps), or cleaning the stale MultiStore pointers.
