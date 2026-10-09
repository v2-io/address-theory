# The addressing exploration (paths demand map)

**How to read this.** The working notes of a focused exploration of addressing (paths) — the design territory everything in Parts III–IV bottoms out on. Nothing here is a ruling: it is a demand map, deliberately ending in a better question set rather than an answer set. The demand table (§8) and the trap list (§9) are the parts the bridges lean on most; the terminator stress cases (§4) are the unfinished work the phase-3 spike inherits.

> **Provenance.** Promoted to the body of this report 2026-07-22. Refinements: this framing introduction; nothing else touched — the text below is the assembled original (gathered 2026-07-21; original file paths in its own frontmatter, which is auditor apparatus).

---

<!-- auditor apparatus — original gathered frontmatter:
- - -
source: second-pass paths demand spike (Grok, 2026-07-21); free-form NOTES
gathered: 2026-07-21
status: gathered source material — NOT an authoritative decision document
paths:
  - v2/.archived/second-pass/spikes/paths/NOTES.md
  - design/udon-paths.md (stale spelling; this spike re-reads load-bearing ideas)
categories:
  - paths
  - addressing
  - at-all
  - embeddability
  - D1-through-D9
  - edit-tool-blocker
why_included: Addressing is the long pole for edit/query/error-as-menu/refs. Whole NOTES + demand table D1–D9. Complements (does not replace) design/udon-paths.md.
- - -
-->


# Paths spike — notes

Exploration pass: 2026-07-21. Free-form. Nothing here is a ruling.

---

## 1. What seems load-bearing (on merits, not on age)

From stale `design/udon-paths.md` + adjudication Part A — principles that still *feel* right when restated cold:

| Principle | Gloss | Tension |
|-----------|--------|---------|
| **No new symbols** | Path language reuses `| : . [ ] @ *` | Positional index and parent-step both want new marks if ever needed |
| **Paths look like UDON** | Linearized document, not XPath-with-sigils | Forces identity purity (see §3) |
| **`at` vs `all`** | Exactly-one-or-error vs explicitly plural | Multiplicity of *matches* vs multiplicity of *stacked values* are different failures |
| **Traits AND-filter** | `.a.b` = both | Matches document desugaring of `$traits` stacking |
| **Refs ⊂ paths (direction)** | One segment today *is* the element segment of a path | Subset floor/ceiling still open |

**Surprise that survived field use** (scenarios corpus): almost every real query starts with `||` (any depth). Structural root-to-leaf navigation is the *secondary* mode. Agents address *relationally* — `||element[key]` as type-scoped primary-key lookup — with the tree as storage/rendering. That is not a decree; it is a one-day sample. Worth stress-testing with append-only logs and prose-heavy docs where keys are unnatural.

---

## 2. Map of consumers that will *pull* path shape

Paths are not a single feature. Demand arrives from different mouths:

```text
                    ┌─ in-document @ references (one segment today)
                    ├─ schema selectors / guarantees
                    ├─ skeleton (copy-pasteable lines)
                    ├─ at / all / each (query)
 assembly product ──┼─ patch / set / require / move (edit tool)
                    ├─ cross-file trace / orphan refs
                    ├─ dialect envelopes later (<path:…>?)
                    └─ multi-line repair / stream addressability (?)
```

**Implication for WAIT-DEMAND:** nailing a “full path language” for tools before embeddability is understood risks a second language that cannot live in documents. Nailing only the in-doc subset first risks path-debt if the subset is grown by special cases (2a Q5 / OPEN S14 lean: keep tuple until wholesale replacement).

---

## 3. Collision map (known forks — still open)

### 3.1 Positional `[0]` vs identity `[1]`  (adjudication P1)

Document law (CORE Identity): bracket contents follow normal value rules. `[1]` is integer key 1; `["1"]` is string key `"1"`.

Stale path doc: integers are *positional*, strings are identity.

Those conflict under “paths look like UDON.”

**Sketch options (not chosen):**

| Opt | Idea | Cost |
|-----|------|------|
| A | Brackets = identity only; position via host `all(…)[i]` | No positional syntax until demand + distinct form |
| B | Distinct positional mark now (`[#0]`, `#0`, …) | New symbol; honest |
| C | Integers positional; quote/`<…>` for integer identities | Shadows legal document keys — worst of both |

Scenario evidence (Part A½): typed-key equality was used (`||intent[42]` ≠ `||intent["0042"]`); positional access was never wanted once. That is **evidence**, not a pin.

### 3.2 References: floor vs ceiling (P0)

Live CORE: one segment; “notably absent by design” for nesting/attrs/ predicates; multiplicity consumer-side; traits filter only.

**Floor candidate:** multi-segment absolute paths in references (`@config|database[primary]`) — still “looks like linearized UDON.”

**Ceiling:** whole tool language including wildcards, `||`, `:attr@` follow.

**Hard constraint the standalone path doc never had:** reference-paths must parse inside documents with clean terminators at value boundaries.  
What does `@config|database` do to the sameline scan? Where does a path end in arrays, in `|{…}`, after bare tokens?

Until that is forced by a real embeddability probe (grammar sketch or hand-table of terminator cases), subset choice is under-constrained.

### 3.3 Stacked attributes and node values (P2)

```udon
|el :x 1 :x 2
|api
  :headers
    |header[auth] :value Bearer
```

Open readings:

- `at("…:x")` over stack → last value? first? error if plural values?
- `all("…:x")` → every assignment in order?
- Navigation into node values: `|api:headers|header[auth]:value` seems natural
- Pre-0.9 `:attr:nested` chaining without an element step — keep or drop?

Plural-path vs plural-value vs plural-reference want **distinct** failure names if the edit tool is to be teachable (scenario draft vocabulary: `PathNotUnique` / `PathNotFound` / `ReferencePlural` / …).

### 3.4 `|.trait` vs `|*.trait` (P3)

Document `|.defaults` = anonymous element with trait `defaults`.

Path `|.intro` could mean “anonymous only” (mirror document) or “any element with trait” (XPath-ish). Mirror-the-document + `|*.intro` for any removes ambiguity without new symbols.

### 3.5 Reference segments inside paths (P6)

- Leading `@user[alice]` — definition lookup (type-scoped index), not host “resolution mode”
- Trailing `:customer@` — follow ref stored in attr; continue at definition
- Unresolvable = loud failure under `at`/`all`, not silent empty?

Composition already appears in scenarios: `||process[valve]:fed-by@:health`, `||*:feeds@`. Also noted as awkward: `||*:*@` (wildcard attr + follow).

### 3.6 What paths *don’t* address (P7, P8, P9)

Deliberate absences worth re-examining under edit-tool pressure, not because “features are good”:

| Absence | Why it was deliberate | Where pressure returns |
|---------|----------------------|-------------------------|
| Parent `..` | Keep language selection-shaped | Relative paths from current node in interactive skeleton |
| Predicates beyond traits+keys | Host-over-`all()` escape | Scenario day: attr-value filter wanted ~4× |
| Globs `\|foo*` | `*` already suffix/trait soup | Never? |
| Prose / comment / raw body segments | Tree has Text nodes; syntax didn’t | Scenario `.gap`: no path addresses prose → no `|set` on paragraph |
| Suffix flags `? ! +` | Traits filter; flags invisible | “Every `?`-marked process” has no path today |

---

## 4. Embeddability sketches (terminator itch)

Today every scenario path is a **quoted string** because a bare leading `|` or `@` in value position is a node/reference value, not text.

```udon
; works today (provisional spelling as string)
|when
  |at :path "||intent[311]:status"

; bare would be structure, not a path value
; |at :path ||intent[311]:status     — not what authors mean
```

**Possible futures (exploratory only):**

1. **Stay quoted forever for tool ops** — paths never need bare value form; in-doc refs stay one-segment `@…`.
2. **Dialect envelope** `<path:||intent[311]:status>` — self-delimiting; interior can use `|` freely; aligns with OPEN W1 self-delimiting lean.
3. **Grow bare `@`/`|` multi-segment** in value position with a hard terminator grammar — highest recognition cost; highest “paths *are* UDON” purity.

**Dead end to flag early:** inventing a second quoting regime just for paths (e.g. special path quotes) while dialects already own envelopes.

### Sameline scan stress cases (hand table — incomplete)

Assume a multi-segment reference is allowed in value position someday:

| Written | Risk |
|---------|------|
| `:db @config\|database[primary]` | Does `\|` end the reference and start a sibling element? |
| `:db @config\|database[primary] :host x` | Where does ref end; is `:host` next attr of owner or of path? |
| `:xs [@a\|b, @c]` | Array item boundaries vs path `|` |
| prose then `@x\|y` mid-line | Head vs prose commitment — ref only at head/value guard sites |
| `:p "\|config\|db"` | String is fine; not a structured path on the wire |

These are the embeddability questions adjudication said a descent prototype should force. **This spike does not build that prototype** — only records that without it, subset claims are soft.

---

## 5. Multi-line (ML) — watch only, do not pin

OPEN **ML** is WAIT-DEMAND. Connection to paths is real but indirect:

- Emergent-span: an *inner* spanning construct defeats a line-bound *container*. Path/edit tools that rewrite interior values will re-hit that geometry.
- Addressing partial/unclosed identity (`$partial-key`) matters for stream repair and incomplete input — path resolution over partial keys should refuse to pretend completeness (already CORE posture for `@`).
- Patch sugar-aware serialization (scenario demand): setting `:'$traits'` should round-trip as `.trait` when possible — that is assembly/fmt territory pulled by path *writes*, not path *syntax* alone.

**Do not** use this spike to close multi-line. If a concrete geometry demand appears, list it under §8 as a provisional proposal.

---

## 6. Multiple keys (OPEN S3) — path-shaped curiosity

Joseph lean (OPEN): `|phase[9][scribal]` valid; design with paths in 0.10.

Questions for later pressure (not answered here):

- Is uniqueness still `(type, key)` or `(type, key-tuple)`?
- Does a path segment allow multiple brackets `|phase[9][scribal]`?
- How does `@phase[9]` behave if keys are multi-part?
- Does this interact with typed equality (`[9]` vs `["9"]`)?

Scenario corpus uses single keys heavily; multi-key is under-exercised.

---

## 7. Wire (OPEN W3) under path pressure

Interim: `Reference` event carries **raw text after `@`**.

Planned: structured `ReferenceStart` / Name / `$key` / `$traits` / End — symmetric with element identity.

Lean in OPEN: raw until paths force structure.

**When structure becomes hard to avoid:**

- Multi-segment paths as references (cannot stay opaque strings without a second parser at every consumer)
- Typed keys / quoted names / trait stacking free (already true on define side)
- Assembly sufficiency (W0): can you recover reference identity without re-lexing raw?

**Counterpressure:** keep tool paths *outside* the recognition stream (always strings / dialect values) so core wire stays simple until demand is undeniable.

---

## 8. Provisional boundary demands

> **Proposals only — not decisions.** Labeled so a later OPEN/PANEL pass can harvest or discard without archaeology.

If Recognition / Assembly / Resolution stages are the spine vocabulary, paths mostly stress **Assembly** (document product, indexes) and **Resolution** (follow `@`, `at`/`all`), with **Recognition** only for in-document path/ref *syntax*.

| # | Stage | Provisional demand | Who pulls | Confidence |
|---|-------|-------------------|-----------|------------|
| D1 | Recognition | In-doc `@` remains self-delimiting as today (one segment) until embeddability of multi-segment is proven | Live consumers, parsers | high as *interim* |
| D2 | Recognition | If multi-segment ever embeds bare, terminator table must be explicit (value boundary, array, brace forms) | Path-in-document authors | medium |
| D3 | Assembly | Type-scoped key index sufficient for `\|type[key]` / `@type[key]` lookup; order-preserving child lists for structural paths | `at`/`all`, skeleton | high |
| D4 | Assembly | Stacked attr access exposes *assignment list*, not only host scalar-last view | edit tool, `all(:attr)` | medium |
| D5 | Resolution | Fail-loud on unresolvable follow (`:attr@`); distinguish PathNotFound / PathNotUnique / ReferencePlural | agent edit tool | high from scenarios |
| D6 | Resolution | Path evaluation for a patch is against **pre-patch** tree (CAS / composition) | multi-agent scenarios | high as *tool* law, maybe not core |
| D7 | Wire | Prefer raw `@` payload until multi-segment or typed structure is forced (aligns OPEN W3 lean) | WIRE suite | medium |
| D8 | Host/tool | Prose/comment/raw addressing may stay API-positional in v1 (no path segment) | edit tool | medium |
| D9 | Host/tool | `at` = exactly one match or error; `all` = explicit plural — do not overload one API | all query surfaces | high as *convention* |

Nothing in D1–D9 is suite law. Wrong is fine.

---

## 9. Dead ends / traps noticed this pass

1. **Treating `design/udon-paths.md` as law** — banner already says stale; positional-integer rule is the sharp trap.
2. **Growing the selector tuple field-by-field** (“add parent path,” “add attr filter”) — 2a Q5 warning; creates path debt without a language.
3. **Confusing match multiplicity with value multiplicity** — stacked `:fed-by` is not the same bug as two `|user[alice]`.
4. **Assuming skeleton paths must be valid *references*** — skeleton may speak the full tool language while in-doc `@` stays a subset forever.
5. **Supply-side multi-line pin “because paths need it”** — reverse of WAIT-DEMAND; demand should appear as concrete edit/stream cases first.
6. **Globs** — confusable with suffix `*` and trait soup; scenario corpus did not need them.
7. **Silent empty on miss** — agent tools need loud failure; JSONPath-ish empty sets teach the wrong habit for contested claims / CAS.

---

## 10. Open questions left richer than when we started

See README itch + the list below. The win condition for this spike is a better question set, not an answer set.

1. **Is the relational (`||type[key]`) mode the primary mental model**, with tree paths as secondary sugar — or the reverse for human authors?
2. **What is the smallest in-document reference subset that is still a true subset of the tool path language** (no second dialect of addressing)?
3. **Where does a multi-segment path terminate** in every CORE value context? (Needs a forced table or tiny grammar probe.)
4. **Should positional addressing ever be syntax**, or only host indexing over ordered `all()` results + eventual patch anchors?
5. **How do multiple identity brackets (`\|phase[9][scribal]`) interact with uniqueness, `@`, and path segments?** (OPEN S3)
6. **Attr-value predicates:** host-only forever, or a second-class filter syntax when frequency data accumulates?
7. **Suffix flags on path segments** (`\|process[x]?`) — mirror document spelling or remain invisible?
8. **Does path *write* sugar (set `$traits` → emit `.trait`) belong in core assembly equivalence, a fmt profile, or only the edit tool?**
9. **Cross-file paths / document handles** — in-path (`file#||x`) vs out-of-band (`:file` on the op, as scenarios do)?
10. **When does W3 leave raw reference payloads** — first multi-segment, first structured consumer, or first sufficiency (W0) proof that needs it?

---

## 11. Pointers for the next agent

- Re-read adjudication Part A½ before inventing syntax — the day-in-the-life already exercised P1/P5/P6 and listed gaps.
- `test/scenarios/features/*.udon` paths are **provisional spelling**; if syntax moves, re-spell scenarios — their value is the *journeys*.
- Sibling spike `v2-spec/spikes/agent-utility/` (if populated) is a natural co-reader; paths without edit/stream stories are half the demand.
- Do not edit DECISIONS/PROCESS/CORE from path enthusiasm.
- Optional harvest: promote a sharpened OPEN row (e.g. embeddability terminator table as WAIT-DEMAND sub-bullet under S14/ML) — only if the question is clearer than what OPEN already says.

