# *Volume* Addressing Theory — Udon Addresses, Paths, References

**Canon view** over `def/` and `src/`. Third edition, reset 2026-08-08 — the skeleton is deliberate: rows appear here only as terms stand in `def/` and prior material earns claw-back from `.archive/` (protocol in `ORIENT.md`). Conventions and register discipline live in `ORIENT.md`; outline-level decisions and their reasons land in the Working Notes below.

---

## *Part* I — Vocabulary Foundation

*The def/ terms, given primacy: each row is a `def/<slug>.ud` segment; `LEXICON.md` is generated from them. Interim carrier until populated: `defs.source.ud` (bannered; retires by integration + delete-test).*

| Expected<br>Type | Tag | Claim | Max | State |
|---|---|---|---|---|
| Definition | [[def-designator]] | Name deliberately bound (minted) to a referent; the binding is the whole connection; dangle/collide | axiomatic | proposed |
| Definition | [[def-location]] | A designator unique within its parent-location's scope; contains sub-locations | axiomatic | proposed |
| Definition | [[def-world]] | Root location with no parent; every location transitively within exactly one world; crossing worlds is never an address step | axiomatic | proposed |
| Definition | [[def-path]] | Ordered steps between origin and destination locations; waypoints; origin/destination as roles | axiomatic | proposed |
| Definition | [[def-address]] | Two or more progressively scoped locations; uniqueness compositional; relative/absolute one definition | axiomatic | proposed |
| Definition | [[def-directions]] | Path that isn't an address; the imperative remainder; the only cross-world mechanism | axiomatic | proposed |

## *Part* II — Theory

*Theory segments build around Part I's terms; populated by claw-back adjudication and fresh drafting. Deliberately empty at reset.*

---

## *Working Notes (outline-level)*

- **Third-edition reset (steward, 2026-08-08):** everything moved to `.archive/second-theory-iteration-2026-08-08/`; only deemed-worthy parts return, deliberately. The prior edition's foundation (descriptor-kind partition as the primary cut, D12's location-as-description seating) is under active re-derivation — the CHEATSHEET-2 line (location as scoped designator; world; address/directions) and the reach/check gap-model dialogue are the live candidates. Part I's rows above carry the CHEATSHEET-2 "well settled" terms as `proposed` until their `def/` segments draft.
- **def/-primacy decision (steward, 2026-08-08):** the prior edition's parallel dev-segments-vs-term-entries split is retired; terms are defined once in `def/`, theory builds around them, `LEXICON.md` generates.
