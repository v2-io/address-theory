# *Volume* Addressing Theory — Udon Addresses, Paths, References

**Canon view** over `def/` and `src/`. Third edition, reset 2026-08-08 — the skeleton is deliberate: rows appear here only as terms stand in `def/` and prior material earns claw-back from `.archive/` (protocol in `ORIENT.md`). Conventions and register discipline live in `ORIENT.md`; outline-level decisions and their reasons land in the Working Notes below.

---

## *Part* I — Vocabulary Foundation

*The def/ terms, given primacy: each row is a `def/<slug>.ud` segment; `LEXICON.md` is generated from them. Interim carrier until populated: `defs.source.ud` (bannered; retires by integration + delete-test).*

| Expected<br>Type | Tag | Claim | Max | State |
|---|---|---|---|---|
| Definition | [[def-reference-act]] | Narrowing material intended to determine referents, from an origin, with expected cardinality; the writing/use gap is constitutive | axiomatic | proposed |
| Definition | [[def-binding]] | Deliberate maintained name→referent association within one scope; mint/dangle/collide; uniqueness is a policed norm, never definitional | axiomatic | proposed |
| Definition | [[def-match]] | Connection by test against the current population; with binding, the two connection mechanisms (exhaustiveness stated with its falsifier); designator/description as derived per-connection classifications | axiomatic | proposed |
| Definition | [[def-scope]] | The unit of resolution locality: holds bindings, originates acts, connects by labeled edges; locally-cheap bindings compose into global reach; root scopes | axiomatic | proposed |
| Definition | [[def-location]] | A scope that is the referent of a binding — a named scope; location-ness is a role | axiomatic | proposed |
| Definition | [[def-resolution]] | Act + origin → result set, each result carrying its resolution path; walk-steps vs mediated-steps; the admissibility/preference policy split; ambiguity as surfaced outcome | axiomatic | proposed |

## *Part* II — Theory

*Theory segments build around Part I's terms; populated by claw-back adjudication and fresh drafting. Deliberately empty at reset.*

---

## *Working Notes (outline-level)*

- **Third-edition reset (steward, 2026-08-08):** everything moved to `.archive/second-theory-iteration-2026-08-08/`; only deemed-worthy parts return, deliberately, on conviction — never as preservation.
- **Foundation cut (this edition, from `defs.source.ud`):** connection *mechanisms* (binding/match) are primitive; designator/description are derived per-connection classifications; scopes are the locality unit and locations are named scopes; resolution is path-carrying and policy-split into admissibility + preference; ambiguity is a surfaced outcome, and binding uniqueness is a policed norm rather than a definitional clause. Two deliberate divergences from the prior edition's sheets are argued in `defs.source.ud`'s own comments (uniqueness-out-of-LOCATION; bind/match-under-designator/description). External grounding: Néron–Tolmach–Visser–Wachsmuth, ESOP 2015 (`ref/esop15/`), whose declarations/scopes/paths/WF+ordering machinery corresponds closely enough to inherit proofs — the correspondence is load-bearing and should be verified again whenever a def/ segment drafts from it.
- **def/-primacy decision (steward, 2026-08-08):** the prior edition's parallel dev-segments-vs-term-entries split is retired; terms are defined once in `def/`, theory builds around them, `LEXICON.md` generates.
