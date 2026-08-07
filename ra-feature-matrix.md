# RA feature matrix

*The five-column instrument (Joseph, 2026-08-07). Dependency runs left → right: **theory features** (near-definitive) → **example usecase** (plain English; the coverage/generalizability check) → **theoretical RA parts** (syntax-free semantic distillation — fillable now) → **SQL + algebraic-types expression** (ideally runnable against an SQL mapping of udon structures) → **udon-RA expression** (most open; spellings last). Right columns double as status until real content lands. Markdown table for now; migrate to udon records when cells outgrow rows.*

**Slot notation for column 3** (from the act anatomy, sketch §12.6 — verbose long-form welcome in any cell that needs it; this is compression, not commitment):

`orig:` origin/perspective (implicit·explicit·universal·binding) · **pathwise segments, marked by sequence-cause**: `seq⊇:[a/b]` subset-sequence (containment chain — declarative, reorderable/fusible) · `seq→:[a/b]` resolver-sequence (imperative, pipeline barrier) · `seq∘:[a/b]` compositional (foldable iff endpoint-only) · `dest:{…}` unordered conjunction · `des:[kind:val]` designators, kind-marked · `ar:{n,m}` operational arity · `exp:{n,m}` epistemic arity · `sel:` plural-selection policy · `pin:` verification descriptor · `mom:` moment · `proj:` projection/output template · `disp:` disposition (insert·carry) · `res:` resolution moment · `pol:` doc-boundary policy · `out:` expected outcome kind · `product:dest|path` whether the endpoint or the route itself is the referent

Status marks for cols 4–5: `—` (not started) · `sketched §N` (a provisional form exists in hypothetical-sketch) · `blocked(X)` (waiting on a named decision).

| # | Theory feature | Example usecase | Theoretical RA parts | SQL+alg | udon-RA |
|---|---|---|---|---|---|
| 1 | Rigid designator lookup | "Open decision d-2026-08-01" | `des:[slug:d-2026-08-01] ar:{1,1}` | — | sketched §2 |
| 2 | Description selection | "Every decision still marked open" | `dest:{el:decision, attr:status=open} ar:{0,*}` | — | sketched §12.2 |
| 3 | Mixed conjunction | "The decision keyed x, in the vivarium ledger" | `orig:store(vivarium) dest:{el:decision} des:[key:x] ar:{1,1}` | — | — |
| 4 | Over-determination / verify | "Resolve by slug; confirm the uuid agrees" | `des:[slug:x][uuid:u] verify:co-refer` | — | sketched §5 |
| 5 | Origin: explicit location | "Relative to this document" / "from store root" | `orig:doc(here)` · `orig:store(S)` | — | — |
| 6 | Origin: universal | "Citable from anywhere in the estate" | `orig:universal des:[instance:asf][store:aat][slug:s]` | — | — |
| 7 | Origin: binding (CTE) | "From prior result a, its ref children" | `orig:bind(a) seq⊇:[ref] ar:{0,*}` | — | sketched §12.4 |
| 8 | Subset-sequence (containment chain) | "Third chapter, then its first code block" | `seq⊇:[chapter#3/code#1]` *(position = location component; reorderable in principle)* | — | sketched §3 |
| 9 | Declarative dest (unordered) | "A p inside any h-level heading, any depth" | `dest:{el:p, within:{el:h?}}` | — | sketched §12.2 |
| 9b | Resolver-sequence (true imperative) | "ssh to host, then find the store, then within it…" | `seq→:[scheme(ssh,v2.io)/find(*mystore*)] seq⊇:[h1/p]` — mixed chain, cause per segment | — | — |
| 9c | Compositional sequence + reducibility | "Down 7, left 3… (just get me there)" vs "…and draw the line" | `seq∘:[…] product:dest` (foldable) vs `product:path` (irreducible — route is the referent) | — | — |
| 10 | Any-depth vs child walk | "Direct children only" vs "anywhere within" | `seq⊇:[a/b]` child vs `seq⊇:[a/**/b]` | — | blocked(walk-default) |
| 11 | Name-glob matching | "All h1/h2/h3…" | `dest:{el:glob(h?)}` | — | sketched §12.2 |
| 12 | Operational arity | "Take them all" / "the one or fail loudly" | `ar:{0,*}` / `ar:{1,1}` | — | sketched §4 |
| 13 | Epistemic expectation | "…but I expect ≤3 or I've misunderstood" | `ar:{1,*} exp:{1,3} → dialogue on divergence` | — | sketched §4 |
| 14 | Plural-selection policy | "Change the *first* occurrence" | `ar:{1,1} sel:first(doc-order)` | — | — |
| 15 | Identify-only (no fetch) | "Cite it; check it exists; reserve the name" | act carries `des:` only; no GET | — | — |
| 16 | Fetch-verification pin | "Edit only if content unchanged since read" | `des:[slug:x] pin:sha256(h)` | — | — |
| 17 | Moment / as-of | "The record as it was at commit C" | `des:[slug:x] mom:commit(C)` | — | — |
| 18 | Entity vs value-object address | "The live record" vs "these exact bytes" | `des:[slug:x]` vs `des:[hash:h]` | — | sketched §6 |
| 19 | Projection (select) | "Just the :name values of the matches" | `dest:{el:person} proj:attr(name)` | — | blocked(slot-vs-composed) |
| 20 | Rewrite / output template | "Matched rows rendered as a summary list" | `dest:{…} proj:template(binds→shape)` | — | — |
| 21 | Set combination / census | "Everything in τ_old but not τ_new; count it" | `comb:diff(actA, actB) proj:count` | — | — |
| 22 | Doc-boundary policy | "All decisions, ignoring file boundaries" | `pol:skip-doc dest:{el:decision}` | — | sketched §6 |
| 23 | Store / BASENAME union | "The TODO store, whatever its current layout" | `orig:store(TODO)` — union over `$DOCUMENT` manifestations | — | sketched §6 |
| 24 | Region / part addressing | "Segment x's Working Notes region" | `des:[slug:x] seq⊇:[region:working-notes]` | — | blocked(region-decl) |
| 25 | Prose-span addressing | "This quoted sentence, for provenance" | `des:[slug:x] seq⊇:[span:word-anchor(a…b)]` | — | — |
| 26 | Typed resolution outcomes | "Ambiguous designator → ranked choices, not error" | `out:unique\|choices\|none\|stale` (engine obligation) | — | — |
| 27 | Canonicity class declared | "This stored ref promises permanence" (or doesn't) | `meta:class(true-id\|canonical\|preferred\|working)` | — | — |
| 28 | Rename lineage / aliases | "Old slug still resolves after the rename" | `des:[slug:new][slug:old(retiring)]` — stacked, lifecycle open | — | sketched §5 |
| 29 | Resolution moment | "Resolve intra-doc early; whole-store refs late" | `res:stage(early\|late\|use)` — LUSS- or consumer-declared | — | sketched §9,§12.1 |
| 30 | Disposition | "Insert it here" vs "carry the act as a value" | `disp:insert` vs `disp:carry` | — | sketched §12.5 |
| 31 | Semantic matcher | "The section that discusses migration windows" | `dest:{semantic:(query text)} exp:{0,3}` — matcher kinds open set | — | — |
| 32 | Directive operand (dynamics) | "foreach over the matches; interpolate el:name" | act as typed literal; consumer resolves; `proj:` per binding | — | sketched §8 |

## Working notes

- **Column-1 closure check (the point of the exercise):** is any addressing need in the corpus *not* expressible as a row here? Current candidates for missing rows: joint/relational join-by-shared-value (mixins — `dest:{shares:trait(t)}`?), write-back contracts (does an act used as an edit target need its own feature row, or is that rows 14+16 composed?), and cross-act constraint ("these two acts must resolve to the same referent").
- **Column-4 plan** (sketch §12.3's theory-lab): an SQL mapping of udon structures — elements/attributes/children as tables (adjacency + attribute EAV-ish), `$DOCUMENT` rows for docs — then each row's act as a query. Rows that resist SQL (25? 31?) are findings, not failures: they mark where the algebra's τ or an engine kind exceeds relational reach.
- **Column-5 discipline:** nothing lands here except by desugar from column 3 — spellings arrive last, per the whole method.
- Rows 10, 19, 24 are blocked on named open decisions (walk default; projection slot-vs-composed; region declaration) — the blocks are the current adjudication frontier, which is exactly what the status columns are for.
