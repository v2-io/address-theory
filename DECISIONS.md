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

## D1 — decided-by vocabulary adopted for this ledger
**Holds:** decisions here carry `decided-by` from the seven-value vocabulary above.  
**Why:** the weight of a decision is who stood behind it and how; recording that is what makes revisiting honest.  
**decided-by:** steward · **date:** 2026-08-07 · **cite:** in-session (steward proposal, coord agreement)

## D2 — aspects-as-spine organization
**Holds:** Part III is organized by capability *aspects*, each progressing theory → cases → RA → SQL → spelling internally; pipeline stages are never the outline's skeleton.  
**Why:** process-as-skeleton is the misfire shape; aspects advance independently and the matrix tracks aspects×stages.  
**decided-by:** steward · **date:** 2026-08-07 · **cite:** OUTLINE Working Notes (organization decision)

## D3 — the feature matrix is a generated view, never authority
**Holds:** segments and the outline are the population; `ra-feature-matrix.md` is to be refreshed *from* them (generator pending); its row-number cites in chapter headers are transitional mapping with no authority.  
**Why:** a hand-maintained tracking artifact cited as authority is the lagging-index trap.  
**decided-by:** steward · **date:** 2026-08-07 · **cite:** OUTLINE Working Notes (authority ruling)

## D4 — the first outline pass is set aside, not source material
**Holds:** `INFLUX/.archive/problem-statement-outline.md` is not drafted from.  
**Why:** superseded by Part I; a corpus-synthesis arranged as an arc — biasing (the confabulation shape).  
**decided-by:** steward · **date:** 2026-08-07 · **cite:** sop/ORIENT.md (doctrina)

## D5 — terms/def unification: entries are projections of segment definition spans
**Holds:** a term entry's definition half is a generated projection of its segment's eq-tagged definition span (naming metadata is the entry's native half); interim pre-tooling discipline per OUTLINE WN; endpoint is a literal reference act with transclude disposition.  
**Why:** segments author, terms render — one source of truth for definition text; the endpoint makes this corpus its own first consumer of sub-atom addressing.  
**decided-by:** supported · **date:** 2026-08-07 · **cite:** OUTLINE Working Notes (terms/def unification design)

## D6 — engine obligation adopted: weak resolution is disclosed (found-but-weakly)
**Holds:** resolution via a weaker descriptor than the strongest carried yields the typed outcome **found-but-weakly**, never a clean hit. Fifth engine obligation in [[def-cardinality-and-resolution]].  
**Why:** without it, over-determination re-creates the silent near-miss it exists to kill; same fail-safe philosophy as `$partial-key`, applied at resolution time; external anchor [verified] (Phelps–Wilensky).  
**decided-by:** ratified · **date:** 2026-08-07 · **cite:** formalisms survey §8 + addendum; founding-coord note ("adopt or decline, don't let them drift")

## D7 — engine obligation adopted: zero only from a completed perspective
**Holds:** an engine answers "empty set" only from a perspective it can attest complete; otherwise the distinct outcome **found-none-so-far**. Sixth engine obligation in [[def-cardinality-and-resolution]]; attestation mechanics deferred to LUSS/engine design (segment WN).  
**Why:** a premature zero is not an answer to the question asked, and mis-teaches through the miss channel; warranted by the Fetch Assumption's own logic (the Kahn connection is corroborating dress, [recall]).  
**decided-by:** ratified · **date:** 2026-08-07 · **cite:** formalisms survey §3 + finding 5

## Overturns

*(none yet)*
