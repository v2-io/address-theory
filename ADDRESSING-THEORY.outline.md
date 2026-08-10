# *Volume* Addressing Theory — Udon Addresses, Paths, References

**Canon view** over `def/` and `src/`. Third edition, reset 2026-08-08 — the skeleton is deliberate: rows appear here only as terms stand in `def/` and prior material earns claw-back from `.archive/` (protocol in `ORIENT.md`). Conventions and register discipline live in `ORIENT.md`; outline-level decisions and their reasons land in the Working Notes below.

---

## *Part* I — Vocabulary Foundation

*The def/ terms, given primacy: each row is a `def/<slug>.ud` segment; `LEXICON.md` is generated from them. Interim carrier until populated: `defs.source.ud` (bannered; retires by integration + delete-test).*

| Expected<br>Type | Tag                   | Claim                                                                                                                                                                                                       | Max       | State    |
| ---------------- | --------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------- | -------- |
| Definition       | [[def-reference-act.ud]] | Referring material intended to determine referents, with expected cardinality as act-anatomy; the writing/use gap is constitutive                                                                           | axiomatic | drafted  |
| Definition       | [[def-binding.ud]]       | Deliberate maintained name→referent association; mint/maintainer/dangle/collide; uniqueness is a policed norm, never definitional                                                                           | axiomatic | drafted  |
| Definition       | [[def-match.ud]]         | Connection by test against the current population; with binding, the two connection mechanisms (exhaustiveness held with its stated refutation condition); designator/description derived per-connection    | axiomatic | drafted  |
| Definition       | [[def-scope.ud]]         | The unit of resolution locality — binding's "jurisdiction" made precise; labeled edges (containment universal); root scopes; locally-cheap bindings compose into global reach                               | axiomatic | drafted  |
| Definition       | [[def-location.ud]]      | A scope that is the referent of a binding — a named scope; location-ness is a role                                                                                                                          | axiomatic | drafted  |
| Definition       | [[def-resolution.ud]]    | Act + origin → result set, each result carrying its resolution path; walk vs mediated steps; the admissibility/preference policy split; ambiguity as surfaced outcome                                       | axiomatic | drafted  |

*Reading order is dependency order: each segment uses only its predecessors (`depends` in each frontmatter). The one deliberate deferral making that true: the act's origin lives in def-resolution, not def-reference-act — resolution is origin-relative; the act itself is not.*

## *Part* II — Theory

*Theory segments build around Part I's terms; populated by claw-back adjudication and fresh drafting. Deliberately empty at reset.*

---

## *Working Notes (outline-level)*

- **Third-edition reset (steward, 2026-08-08):** everything moved to `.archive/second-theory-iteration-2026-08-08/`; only deemed-worthy parts return, deliberately, on conviction — never as preservation.
- **Foundation cut (this edition, from `defs.source.ud`):** connection *mechanisms* (binding/match) are primitive; designator/description are derived per-connection classifications; scopes are the locality unit and locations are named scopes; resolution is path-carrying and policy-split into admissibility + preference; ambiguity is a surfaced outcome, and binding uniqueness is a policed norm rather than a definitional clause. Two deliberate divergences from the prior edition's sheets are argued in `defs.source.ud`'s own comments (uniqueness-out-of-LOCATION; bind/match-under-designator/description). External grounding: Néron–Tolmach–Visser–Wachsmuth, ESOP 2015 (`ref/esop15/`), whose declarations/scopes/paths/WF+ordering machinery corresponds closely enough to inherit proofs — the correspondence is load-bearing and should be verified again whenever a def/ segment drafts from it.
- **def/-primacy decision (steward, 2026-08-08):** the prior edition's parallel dev-segments-vs-term-entries split is retired; terms are defined once in `def/`, theory builds around them, `LEXICON.md` generates.
