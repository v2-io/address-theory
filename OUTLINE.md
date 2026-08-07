# *Volume* Paths & References — the addressing theory

**Working draft — v0, 2026-08-07.** Canon view over `src/`. Conventions follow the verisectorium theory's exemplars (`~/src/arch/firmatum/verisectorium/theory/OUTLINE.md` + its `sop/ORIENT.md`): `State` describes (`proposed` until a draft exists, `drafted` after; checks are resettable flags, not ratchets); `Expected Type` is a prediction drafting may overturn; `Max` is the ceiling, assignable from claim-kind; slugs carry form-kind prefixes only (`def-` `claim-` `form-` `obs-`); `[[wikilinks]]`. Frontmatter schema is provisional pending the verisectorium epistemology decision — stated once here, not per-segment.

**Register.** Part I is the split of `theory-and-lexicon.md` (the most nailed-down material; steward-iterated) — drafted, *not* yet steward-verified row by row. Parts II–III are provisional homes: rows over material that is explicitly wet clay (`hypothetical-sketch.md`, which stays live) or fresh survey evidence (`INFLUX/formalisms-survey-2026-08-07.md`, whose `[recall]` items are unverified by its own banner). The register discipline from the README binds throughout: the current grammar is a fact to price, never the verdict.

**Terms.** The embedded lexicon store is `terms/` — one entry per term, seeded from Part I's vocabulary. Terms and canon co-evolve; a segment introducing a term owns updating its entry.

---

## *Part* I — Foundations

*Shape: a few grouped **formal definition segments** — each feeding the `terms/` lexicon directly — with the postal on-ramp as an introduction segment before them and the argumentative material as discussion segments around them.*

| Expected<br>Type | Tag | Claim | Max | State |
|------|-----|-------|-----|-------|
| Discussion | [[intro-postal-model]] | The on-ramp: a mailing address as a reference act; each line strips candidates; the refused-package incident; ambiguity is not a special error — it is what insufficient narrowing *is*. Load-bearing for every later definition; stays first in any view | discussion-grade | drafted |
| Definition | [[def-descriptors]] | The formal core: REFERENCE ACT · DESCRIPTOR · REFERENT · DESIGNATOR (bound by agreement; dangles or collides) · DESCRIPTION (satisfied by fact, recomputed per use; silently re-satisfies) · mixed conjunctions · partial identity = a good designator whose naming community is too large for the job | axiomatic | drafted |
| Definition | [[def-locations-and-paths]] | IDENTITY vs LOCATION (containment coordinates — designators for nesting containers, which route) · the held-lightly reduction (location = identity in a resolvable containment hierarchy; one kind, two working roles, both kept) · PATH (monotonic steps origin→destination) · UNIVERSAL / INTERMEDIATE LOCATION (explains the URI conflation rather than observing it) · progressive routing and its quiet consequences | axiomatic | drafted |
| Definition | [[def-cardinality-and-resolution]] | EXPECTED CARDINALITY (part of the act's type; four bounds give a miss its meaning; operational ⊥ epistemic bounds — failure vs dialogue; recorded bounds = free calibration) · RESOLUTION ENGINE + PERSPECTIVE (same act, legitimately different answers) · the four engine obligations (typed outcomes; descriptors preserved; never a silent best-guess; fetch-verification when carried) | axiomatic | drafted |
| Definition | [[def-entities-values-promises]] | ENTITY (identity independent of description; minted + maintained by convention) vs VALUE OBJECT (is its description) with the addressing consequences that fall out (hash = complete description in designator shape; git refs/blobs) · canonicity as four distinct *promises*: TRUE IDENTITY / CANONICAL LOCATION / PREFERRED LOCATION / WORKING PATH — canonicity is social | axiomatic | drafted |
| Discussion | [[disc-fetch-and-overdetermination]] | Two arguments the definitions enable: the Fetch Assumption made explicit (four seams — acts stopping before the fetch; identity without route; wrong-referent fetch → addresses carrying expectations; a fetch returns a description-as-of-now, never the thing) · over-determination as conjunction's second job (co-referring disagreement is loud verification; redundant routes) | discussion-grade | drafted |
| Derived | [[claim-sequence-causes]] | "Pathwise" is three causes in one costume: subset-sequence (nested conjunction wearing a path costume — the general law behind the path/location/destination conflation), resolver-sequence (truly imperative; pipeline barrier), compositional (foldable iff endpoint-only and associative; irreducible when the referent *is* the route); cause is per-segment and is exactly what an engine may optimize | robust-qualitative | drafted |
| Observation | [[obs-address-components]] | Brief survey of common location / identity / description components in the wild (URI conflation, keys, UUIDs, globs, content addresses; the deliberately-absent scheme/auth/filetype note) | empirical | drafted |

---

## *Part* II — Common Capabilities

*Cross-aspect machinery: what applies to every area of the matrix. Populated by **demand-driven promotion** — a thing moves here when it proves cross-cutting, never pre-fabricated (the introduce-before-used discipline). Sourced from the sketch's genuinely cross-cutting pieces; each stays wet clay until drafted.*

| Expected<br>Type | Tag | Claim | Max | State |
|------|-----|-------|-----|-------|
| Formulation | [[form-act-value]] | `@<…>` as a first-class typed reference-act value — an envelope-family typed literal (`@<X>` ≅ `<ref:X>`), grep-friendly sugar; possibly never user-facing (an IR surface dialects desugar to) (sketch §1, §8) | decided | proposed |
| Formulation | [[form-act-anatomy]] | The act's slots: origin · route segments (marked by sequence-cause; order matters) · destination conjunction (unordered) · designators + double arity · projection · disposition — PATH-imperative vs DEST-declarative kept very particular even if slots collapse (sketch §12.6; consumes [[claim-sequence-causes]]) | decided | proposed |
| Hypothesis | [[claim-acts-as-operands]] | Every directive operand is a typed literal and acts are one type; the whole dynamics tier reduces to control flow + acts + projections + filters; laziness and keep-everything by construction (sketch §8; one open bit: who parses `@<…>` in heads) | robust-qualitative | proposed |
| Formulation | [[form-resolve-moments]] | Retain-and-emit default (AST carries the act; serializer emits it back); resolution moment owned by consumer or LUSS stage; live/once/materialized as caller policy over one value kind (sketch §12.1; confluence routed to Part IV) | decided | proposed |
| Formulation | [[form-luss]] | The Logical Udon Store Spec (name pending): fluxes, layout ladder, pipeline, schema/dialect bindings; the decider of resolution moments; standing hypotheses — NORMS reduces to it, verisectorium's store triplet rides it (sketch §9) | decided | proposed |
| Hypothesis | [[claim-type-algebra-correspondence]] | A step is a τ; designator = singleton-forcing constraint; walk = composition through containment; arities = the algebra's exponents; set ops free; schema = named ratified act with closure declaration — one evening of enthusiasm, zero adversarial passes; hostile question: the decidability fences under walk-composition (sketch §10) | robust-qualitative | proposed |

---

## *Part* III — Aspects

*The main organization (steward-directed 2026-08-07): one chapter per capability aspect, whose segments progress **theory → examples/usecases → syntax-free theoretical RA → SQL+algebraic-types → udon-RA spelling** — the matrix's left→right dependency as each chapter's internal arc. [`ra-feature-matrix.md`](ra-feature-matrix.md) is the source and the tracking instrument (rows×columns = aspects×stages; its marks are the state vocabulary). Theory-stage content mostly links back to Part I; spelling-stage content arrives last, fed by the sketch's aspect-specific pieces. Row grouping below cites matrix row numbers; chapters are provisional carves of the 32 rows and may re-group as RA drafting teaches us.*

*Stage-row convention: each chapter seeds three rows — `disc-<aspect>-cases` (usecases, plain English), `form-<aspect>-ra` (theoretical RA parts, syntax-free), `form-<aspect>-spelling` (SQL-lab + udon-RA, blocked on the RA row). Rows draft left-to-right; a spelling row drafting before its RA row is the process violation to watch for.*

### *Chapter* Designation & Aliases *(matrix 1, 4, 28)*

| Expected<br>Type | Tag | Claim | Max | State |
|------|-----|-------|-----|-------|
| Discussion | [[disc-designation-cases]] | Rigid lookup; resolve-by-one-verify-by-another; rename survival via stacked designators | discussion-grade | proposed |
| Formulation | [[form-designation-ra]] | `des:[kind:val]` kind-marked designator conjunctions; verify:co-refer; lineage/retirement (the LINEAGE question) | decided | proposed |
| Formulation | [[form-designation-spelling]] | Multi-designator stacking `[a][#b][c]` (sketch §5); blocked(form-designation-ra) | decided | proposed |

### *Chapter* Description & Selection *(matrix 2, 9, 11, 31)*

| Expected<br>Type | Tag | Claim | Max | State |
|------|-----|-------|-----|-------|
| Discussion | [[disc-selection-cases]] | Open-status queries; any-depth destination conjunctions; name-globs; semantic matchers | discussion-grade | proposed |
| Formulation | [[form-selection-ra]] | `dest:{…}` unordered conjunctions; matcher kinds as an open set (lexical/structural/semantic) | decided | proposed |
| Formulation | [[form-selection-spelling]] | Glob-native act interior; the `*`/`?` positional-seat settlement (sketch §12.2); blocked(form-selection-ra) | decided | proposed |

### *Chapter* Origins & Perspectives *(matrix 5, 6, 7)*

| Expected<br>Type | Tag | Claim | Max | State |
|------|-----|-------|-----|-------|
| Discussion | [[disc-origin-cases]] | Doc-relative, store-root, universal/estate-citable, binding-as-origin (CTE) | discussion-grade | proposed |
| Formulation | [[form-origin-ra]] | `orig:` rungs incl. O13's perspective decomposition (host/protocol … within-project match); binding origins | decided | proposed |
| Formulation | [[form-origin-spelling]] | Origin glyphs + binding composition (sketch §12.4); blocked(form-origin-ra) | decided | proposed |

### *Chapter* Sequence & Walk *(matrix 8, 9b, 9c, 10)*

| Expected<br>Type | Tag | Claim | Max | State |
|------|-----|-------|-----|-------|
| Discussion | [[disc-walk-cases]] | Containment chains; mixed resolver chains; offsets with/without route-as-product; child vs any-depth | discussion-grade | proposed |
| Formulation | [[form-walk-ra]] | `seq⊇/seq→/seq∘` cause-marked segments ( [[claim-sequence-causes]]); `product:dest\|path`; walk-default question | decided | proposed |
| Formulation | [[form-walk-spelling]] | `/` and any-depth spellings (sketch §3); blocked(form-walk-ra, walk-default) | decided | proposed |

### *Chapter* Arity & Expectation *(matrix 12, 13, 14)*

| Expected<br>Type | Tag | Claim | Max | State |
|------|-----|-------|-----|-------|
| Discussion | [[disc-arity-cases]] | Take-all vs the-one-or-fail; epistemic dialogue; plural-selection policy | discussion-grade | proposed |
| Formulation | [[form-arity-ra]] | `ar:{n,m}` + `exp:{n,m}` double bound ( [[def-cardinality-and-resolution]]); `sel:` policy | decided | proposed |
| Formulation | [[form-arity-spelling]] | Kleene-suffix sugar at its fifth site (sketch §4); blocked(form-arity-ra) | decided | proposed |

### *Chapter* Verification, Moments & Value Addressing *(matrix 15–18)*

| Expected<br>Type | Tag | Claim | Max | State |
|------|-----|-------|-----|-------|
| Discussion | [[disc-verification-cases]] | Identify-only acts; edit-if-unchanged pins; as-of moments; live-record vs exact-bytes | discussion-grade | proposed |
| Formulation | [[form-verification-ra]] | `pin:` `mom:` and entity-vs-value designation ( [[def-entities-values-promises]]) | decided | proposed |
| Formulation | [[form-verification-spelling]] | `$DOCUMENT`-designator pins (sketch §6 partial); blocked(form-verification-ra) | decided | proposed |

### *Chapter* Projection & Rewrite *(matrix 19, 20, 21)*

| Expected<br>Type | Tag | Claim | Max | State |
|------|-----|-------|-----|-------|
| Discussion | [[disc-projection-cases]] | Attribute projection; output templates; set-combination census/migration | discussion-grade | proposed |
| Formulation | [[form-projection-ra]] | `proj:` `comb:`; bounded-comprehension guardrail; slot-vs-composed (likely dissolved — survey §5) | decided | proposed |
| Formulation | [[form-projection-spelling]] | Comprehension surface (sketch §12.3); blocked(form-projection-ra) | decided | proposed |

### *Chapter* Boundaries, Stores & Spans *(matrix 22–25)*

| Expected<br>Type | Tag | Claim | Max | State |
|------|-----|-------|-----|-------|
| Discussion | [[disc-boundary-cases]] | Ignore-file-boundaries queries; BASENAME/store unions; region + prose-span addressing | discussion-grade | proposed |
| Formulation | [[form-boundary-ra]] | `pol:` policies; store-as-`$DOCUMENT`-union; `region:`/`span:` (anchoring ladder — Part IV [[form-anchoring-ladder]]) | decided | proposed |
| Formulation | [[form-boundary-spelling]] | `$DOCUMENT` spelling + store designators (sketch §6); blocked(form-boundary-ra, region-decl) | decided | proposed |

### *Chapter* Outcomes & Dispositions *(matrix 26, 27, 29, 30, 32)*

| Expected<br>Type | Tag | Claim | Max | State |
|------|-----|-------|-----|-------|
| Discussion | [[disc-outcome-cases]] | Ranked-choices on ambiguity; declared canonicity class; early/late resolution; insert vs carry; directive operands | discussion-grade | proposed |
| Formulation | [[form-outcome-ra]] | `out:` typed outcomes ( [[def-cardinality-and-resolution]] + found-but-weakly candidate); `meta:class()`; `res:stage()`; `disp:` | decided | proposed |
| Formulation | [[form-outcome-spelling]] | `@{…}`/`@<{…}>` disposition pair (sketch §2, §12.5); blocked(form-outcome-ra) | decided | proposed |

---

## *Part* IV — Evidence & Formal Grounding

*Rows are provisional homes over `INFLUX/formalisms-survey-2026-08-07.md`; its `[recall]` items are unverified by its own banner and stay so until checked.*

| Expected<br>Type | Tag | Claim | Max | State |
|------|-----|-------|-----|-------|
| Claim | [[claim-scope-graph-grounding]] | Scope graphs (Néron et al. 2015, [verified]) pre-formalize the central object: resolution = path-finding under a regular edge-label constraint + declared visibility ordering; engines = path-label policies over one graph; inheritable soundness + renaming theory; our delta = arity/epistemic bounds, canonicity classes, verification pins, sequence-causes (survey §1) | robust-qualitative | proposed |
| Claim | [[claim-carry-perspective]] | The confluence answer from forty years of hygiene work: stage order doesn't buy confluence — *the act carries its perspective*; materializations carry their perspective + moment or they are lies waiting to age (survey §2, finding 2; composes with [[form-resolve-moments]]) | robust-qualitative | proposed |
| Claim | [[claim-pipeline-determinacy]] | Kahn licenses aggressive streaming/parallelism *within* a declared stage order, and is silent on order itself — zero-as-answer requires an attestably complete perspective (a still-filling store is a non-blocking read); the remaining confluence is a per-pass commutation matrix, which *is* the semantic content of a LUSS stage ordering (survey §3–4) | robust-qualitative | proposed |
| Claim | [[claim-route-as-semiring]] | `product:dest` vs `product:path` is the choice of semiring at evaluation time; folding is the homomorphism, "reduction is destruction" formally; the warning: provenance under *difference* is the field's open edge — census/migration acts can't promise route-products yet (survey §6) | robust-qualitative | proposed |
| Claim | [[claim-binder-cliff]] | Hybrid logic locates the decidability cliff: nominals/@ᵢ cheap; the ↓ binder (in-act "this very node" equality) undecidable — keep referent-equality as an act-*pair* obligation, never an in-act operator (survey §7) | robust-qualitative | proposed |
| Formulation | [[form-anchoring-ladder]] | Prose-span addressing adopts the Phelps–Wilensky / Web-Annotation selector-stack shape ([verified]): multiple independent descriptors + fallback ladder + surfaced confidence; adds the missing typed outcome **found-but-weakly** (resolution via a weaker descriptor than carried, said so) — `$partial-key` is the same doctrine at recognition time (survey §8 + addendum) | decided | proposed |

---

## *Instruments*

- **[`ra-feature-matrix.md`](ra-feature-matrix.md)** — **the primary source for the formalization segments and the instance's tracking instrument**: rows×columns = aspects×stages, so its marks (`—`/`sketched`/`blocked`) are Part III's state vocabulary; its left→right dependency is each chapter's internal arc; its column-1 closure check is the standing completeness probe for the aspect carve.
- **[`hypothetical-sketch.md`](hypothetical-sketch.md)** — stays live (wet clay); its cross-cutting pieces are Part II's homes-in-waiting, its aspect-specific pieces feed Part III's *spelling-stage* rows (arriving last per aspect, where the left→right dependency puts spellings); not dispatched until its texture lands in drafted segments (delete-test).
- **[`INFLUX/`](INFLUX/)** — evidence and set-aside material; the formalisms survey feeds Part III; `problem-statement-outline.md` is set aside as superseded by Part I (steward call, 2026-08-07 — biasing content, do not draft from it).

---

## *Working Notes (outline-level)*

- **Coherence review of theory-and-lexicon at split time (2026-08-07, the splitting coord):** the document was substantially more coherent and self-contained than flagged — read whole before splitting; every section survived into a segment with content intact. Issues found and handled: (a) an editor meta-note in canon voice ("*(The IPFS/IPNS treatment removed from an earlier draft belongs here once this section settles)*") — moved to [[def-entities-values-promises]]'s Working Notes; (b) [[claim-sequence-causes]] carries O13-adjacent content with thin provenance (no cite to DISCUSSION-THOUGHTS) — cite added in its WN; (c) title said "Problem Statement" while the README called it theory-and-lexicon — resolved by the split; (d) the footnote on deliberately-absent URL components (scheme/auth/filetype) kept with [[obs-address-components]]; (e) no reader-context assumptions found that a fresh reader would trip on, *given* Part I is read in outline order — the postal example is the load-bearing on-ramp and [[intro-postal-model]] must stay first in any view.
- **Source disposition:** `theory-and-lexicon.md` → `INFLUX/.integrated/` after per-segment content verification by the splitter (delete-test: every section's content is in exactly one segment; the split is a carve, not a rewrite — original prose preserved nearly verbatim per the originals-beside discipline, reorganized into cadence only).
- **What Part I does *not* yet carry (recently-nailed elsewhere, wanted here):** identity-addresses vs view-addresses (verisectorium naming brainstorm); the store-selector vs form-kind-prefix axis distinction; O13's full perspective decomposition + match-vs-walk (partially absorbed by [[claim-sequence-causes]] and [[form-act-anatomy]], not yet stated as the address-slot theory). Candidate future rows, deliberately not fabricated tonight.
- **Survey follow-ups it flagged for itself:** verify all `[recall]` items before external citation (Wong conservativity venue; ↓ undecidability frame conditions; Flatt year; monus/difference state of the art); the two `[verified]` anchors are citable now.
- **Authority ruling (steward, 2026-08-07): the matrix is a *generated view*, never the authority.** Segments (and this outline over them) are the population; `ra-feature-matrix.md` should be *refreshed from* them once tooling exists, not referenced as if it governs. The matrix row-numbers cited in Part III chapter headers are **transitional mapping only** — kept so the correspondence survives until a generator replaces the hand-maintained file; they carry no authority and drop when regeneration lands.
- **Organization decision (steward, 2026-08-07):** aspects-as-spine with per-aspect stage progression (axis B) chosen over parts-by-pipeline-stage (axis A) — axis A would have made the process the skeleton (the misfire shape); under axis B each aspect advances theory→examples→RA→SQL→spelling independently, the matrix serves as the aspects×stages tracking instrument, and Common is populated only by demand-driven promotion. The earlier sketch-shaped Part II was reorganized accordingly the same day it was laid — its rows redistributed to Common (cross-cutting) and the aspects' spelling stages (specific).
- **This instance dogfoods the verisectorium theory** (store triplet minus SOP — praxes ride the theory instance's `sop/ORIENT.md` per [[form-canon-praxes-projection]]; lexicon embedded at `terms/`; INFLUX present). Feedback on the conventions themselves routes to the theory instance's SOP influx.
