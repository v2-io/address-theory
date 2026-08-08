# DECISIONS — present-truth ledger

*One entry per decision: what holds, why (short), decided-by, date, cite. Append or expressly overturn; never silently rewrite. History and deliberation live in `CHANGELOG.md` and the cited records — this file stays thin.*

**The `decided-by` vocabulary** (adopted D1; a variation of vivarium's convention):

| Value | Meaning |
|---|---|
| `steward` | Steward made the call; agent or council ratified |
| `ratified` | Agent made the call; steward ratified |
| `council` | With granted authority, agent made the call after red-teaming and unified validation from other agents |
| `supported` | Agent made the call with steward/council's *provisional* support — less weight, easier revisit than the three above |
| `defacto` | "Decided" without really being decided; recorded so the record exists |
| `proposed` | From steward or any agent; not blocking anything yet |
| `transition` | Rejected but still existing somewhere — defacto-but-being-fixed |

---

## D1 decided-by-vocabulary

**decided-by vocabulary adopted for this ledger.**

**Holds:** decisions here carry `decided-by` from the seven-value vocabulary above.  
**Why:** the weight of a decision is who stood behind it and how; recording that is what makes revisiting honest.  
**decided-by:** steward · **date:** 2026-08-07 · **cite:** in-session (steward proposal, coord agreement)

## D2 aspects-as-spine

**aspects-as-spine organization.**

**Holds:** Part III is organized by capability *aspects*, each progressing theory → cases → RA → SQL → spelling internally; pipeline stages are never the outline's skeleton.  
**Why:** process-as-skeleton is the misfire shape; aspects advance independently and the matrix tracks aspects×stages.  
**decided-by:** steward · **date:** 2026-08-07 · **cite:** OUTLINE Working Notes (organization decision)

## D3 matrix-generated-view

**the feature matrix is a generated view, never authority.**

**Holds:** segments and the outline are the population; `ra-feature-matrix.md` is to be refreshed *from* them (generator pending); its row-number cites in chapter headers are transitional mapping with no authority.  
**Why:** a hand-maintained tracking artifact cited as authority is the lagging-index trap.  
**decided-by:** steward · **date:** 2026-08-07 · **cite:** OUTLINE Working Notes (authority ruling)

## D4 outline-set-aside

**the first outline pass is set aside, not source material.**

**Holds:** `INFLUX/.archive/problem-statement-outline.md` is not drafted from.  
**Why:** superseded by Part I; a corpus-synthesis arranged as an arc — biasing (the confabulation shape).  
**decided-by:** steward · **date:** 2026-08-07 · **cite:** sop/ORIENT.md (doctrina)

## D5 terms-projection

**terms/def unification: entries are projections of segment definition spans.**

**Holds:** a term entry's definition half is a generated projection of its segment's eq-tagged definition span (naming metadata is the entry's native half); interim pre-tooling discipline per OUTLINE WN; endpoint is a literal reference act with transclude disposition.  
**Why:** segments author, terms render — one source of truth for definition text; the endpoint makes this corpus its own first consumer of sub-atom addressing.  
**decided-by:** supported · **date:** 2026-08-07 · **cite:** OUTLINE Working Notes (terms/def unification design)

## D6 found-but-weakly

**engine obligation adopted: weak resolution is disclosed (found-but-weakly).**

**Holds:** resolution via a weaker descriptor than the strongest carried yields the typed outcome **found-but-weakly**, never a clean hit. Fifth engine obligation in [[def-cardinality-and-resolution]].  
**Why:** without it, over-determination re-creates the silent near-miss it exists to kill; same fail-safe philosophy as `$partial-key`, applied at resolution time; external anchor [verified] (Phelps–Wilensky).  
**decided-by:** ratified · **date:** 2026-08-07 · **cite:** formalisms survey §8 + addendum; founding-coord note ("adopt or decline, don't let them drift")

## D7 completed-perspective

**engine obligation adopted: zero only from a completed perspective.**

**Holds:** an engine answers "empty set" only from a perspective it can attest complete; otherwise the distinct outcome **found-none-so-far**. Sixth engine obligation in [[def-cardinality-and-resolution]]; attestation mechanics deferred to DON/engine design (segment WN).  
**Why:** a premature zero is not an answer to the question asked, and mis-teaches through the miss channel; warranted by the Fetch Assumption's own logic (the Kahn connection is corroborating dress, [recall]).  
**decided-by:** ratified · **date:** 2026-08-07 · **cite:** formalisms survey §3 + finding 5

## D8 wikilink-designators

**wikilink stems reclassified: designators by binding, not descriptions by spelling.**

**Holds:** a wikilink stem under a maintained stem-uniqueness discipline is a natural-key designator (collision = loud, mint-time-detectable fork); the description-like behavior is the *unpoliced degenerate case*. Descriptor kind is determined by whether anyone keeps the binding, never by the spelling. Wikilink examples in [[def-descriptors]], [[def-cardinality-and-resolution]], [[obs-address-components]] re-classified accordingly.  
**Why:** the split carried in an agent-synthesis straw-man ("a description wearing a designator's clothes") that inverted the steward's model — the stem *is* the entity's natural-key identity, which is what makes forks visible. Standing steward skepticism recorded alongside (def-descriptors WN): "silent re-satisfaction" as a concept may itself be state-based cruft an event-sourced foundation dissolves — adjudication deferred to the temporal-dynamics work.  
**decided-by:** supported · **date:** 2026-08-07 · **cite:** in-session steward pushback + ratification ("go ahead and make them as supported")

## D9 don-name

**the store spec is named DON (ex-LUSS).**

**Holds:** the udon store spec (fluxes, layout-as-mechanisms, pipeline, schema/dialect bindings, decider of resolution moments) is named **DON**, from donburi (丼, the serving bowl). Slug `form-luss` → `form-don`. History layers keep "LUSS" verbatim; present-truth surfaces carry DON with an ex-LUSS marker at first mention per file.  
**Why:** steward called for the rename ("something potentially japanese… cooked-udon… or udon-store"); donburi won on the standalone-citability test — one syllable in use, bowl = store (the corpus already speaks in bowl-vocabulary, O16), udon-served-in-a-don as free mnemonic. *kama* and *nabe* were considered and set aside for Japanese slang baggage (okama/onabe).  
**decided-by:** steward · **date:** 2026-08-08 · **cite:** in-session (coord candidates + recommendation; steward selection)

## D10 term-un-format

**.term.un replaces .md as the term-entry format.**

**Holds:** `terms/*.term.un` (instantiations of `verisectorium/template/TERM.term.un`) are the entries of record; the founding `.md` entries are archived at `terms/.archive/`. `bin/refresh-lexicon` reads `.term.un`; `bin/terminology-diagrams` derives Euler/relation views from its `|set-rel`/`|rel` graph.  
**Why:** the `.md` entries carried only slug + defined-by + paraphrase — "missing everything that makes it useful" (steward); the template (from the verisectorium terminology survey) adds designations-with-status, formal/set expressions, duals, boundaries, markers, and the Euler-derivable set-relation substrate.  
**decided-by:** steward · **date:** 2026-08-08 · **cite:** in-session ("we should replace the .md terms completely"); fork report + template feedback in verisectorium theory sop/INFLUX

## D11 universal-path

**"universal location" re-carved as UNIVERSAL PATH (syn. absolute path); origin/destination minted.**

**Holds:** the concept formerly designated UNIVERSAL LOCATION attaches to **path**, not location: a **UNIVERSAL PATH** is a path whose origin is universal — within a bounded resolution context it routes to its destination from any origin (synonym: absolute path). A path has exactly one origin (one of explicit | implicit | universal) and one destination; `origin` and `destination` are minted as terms ("yes unless there is something better"). Canon updated in [[def-locations-and-paths]] (+ cross-refs in [[claim-sequence-causes]], [[obs-address-components]]); the promise-table knock-on (canonical/preferred defined via "universal location") is flagged in [[def-entities-values-promises]] WN, not yet adjudicated.  
**Why:** the old designation itself committed the path/location conflation the segment diagnoses — universality (origin-independence) is a property of the route, never of the place reached. Steward: "It's not a universal location — it's a kind of path." The tell that surfaced it: "from any origin" — *from* is path-vocabulary.  
**decided-by:** steward · **date:** 2026-08-08 · **cite:** in-session (ERD-review dialogue; coord's comprehension probe answer carrying the tell)

## D12 location-is-description

**location re-carved: a containment description built from a container designator.**

**Holds:** a LOCATION is a **containment predicate over a designated container** — the containment coordinate (the container's name) is a designator; the location (the contained-in claim) is a **description**, so `location ⊂ description` and `containment-coordinate ⊂ designator`, and def-descriptors' partition holds without a third arm. Its distinguishing marks vs free predicates: subset-semantics composability, delegable resolution (the owned description), partial policing. Standing alone a location is a **scope** (candidate mint); origin/destination/intermediate are *roles* locations fill. Companion derived result: **descriptor-kind is per-act** (resolution is recursive; every chain bottoms out in designators).  
**Why:** D11 removed universality from location and exposed the seating question; the steward pressed it ("is it just a synonym for descriptor?") and ratified the carve ("that sounds about right"). The per-act relativity resolves the steward's three-cluster mental model honestly — the clusters are altitudes sharing designators as atoms, a theorem rather than a leak.  
**decided-by:** ratified · **date:** 2026-08-08 · **cite:** in-session dialogue (coord carve + steward ratification)

## Overturns

*(none yet — D11 re-carves a designation; the concept and its explanatory claims stand)*
