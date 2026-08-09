---
slug: def-cardinality-and-resolution
form: definition
type-expected: definition
status: axiomatic
max: axiomatic
state: [drafted]
depends: [def-descriptors]
terms-required: [reference-act, referent, designator, description]
terms-relevant: [over-determination]
---

# Definition: Expected Cardinality, Engines, and Perspectives

A [[term/reference-act|reference act]] carries an expected cardinality that gives a miss its meaning; resolution is performed by an engine relative to a perspective, and every engine owes the actor four things.

## Formal Expression

*[Definition (expected-cardinality)]* A reference act carries — implicitly or explicitly — an **EXPECTED CARDINALITY**: how many [[term/referent|referents]] the actor means to pick out. This is part of the act's *type*, knowable before any resolution happens, and it is what gives a miss its meaning:

- Under expect-**exactly-one** ({1,1}), zero or several is a *loud failure* — the actor's model of the world is wrong, and they need to know.
- Under expect-**maybe-one** ({0,1}), zero is an *answer*: absent.
- Under expect-**any-number** ({0,N}), zero is an *answer*: empty set.
- Under expect-**at-least-one** ({1,N}), only zero is a failure.

Same descriptors, same world, four different meanings of the same result — the bound is what disambiguates. [[term/designator|Designators]] default to {1,1}; [[term/description|descriptions]] have no natural default, which is why unstated bounds on descriptions are where surprises live — an *unpoliced* stem-match is the mass case (under a maintained stem-uniqueness discipline the {1,1} is stated by the convention itself; see [[def-descriptors]]).

*[Definition (double-bound)]* There are really **two bounds with different jobs**, usually conflated: the *operational* bound (how many the act will touch — "change the first," "take them all") and the *epistemic* bound (how many the actor believes exist — "I expect no more than three, or I've grossly misunderstood the data"). Divergence from the operational bound is failure; divergence from the epistemic bound is *information* — ideally a dialogue ("several exceed three — proceed anyway?"), not a binary error. Recorded epistemic bounds are also calibration data for free: what actors believed about the corpus, checked against reality at every act.

*[Definition (engine-and-perspective)]* Resolution is not a property of the reference act — it is performed by a **RESOLUTION ENGINE** relative to a **PERSPECTIVE** (an origin, a scope, a moment, a policy about what counts as the world). The same act may legitimately resolve differently under different engines: against the logical corpus ignoring document boundaries, against the filesystem layout, against the state as-of a moment, against one declared store's population. This is not ambiguity to eliminate — it is progressive routing's structure ( [[def-locations-and-paths]]): *someone* must own each hop, and the engine is the composite owner.

*[Formulation (engine-obligations)]* What every engine owes the actor, regardless of perspective (these follow from the Fetch Assumption's seams — [[disc-fetch-and-overdetermination]] — not from taste):

- **Typed outcomes even on failure** — found-one / found-many (with the candidates) / found-none / found-but-stale / found-but-weakly / found-none-so-far — because each routes to a different repair, and collapsing them teaches the actor nothing.
- **The requested descriptors preserved beside the result** — some consumers need what was asked, some need what was found; discarding either destroys information the act carried.
- **Never a silent best-guess.** Where narrowing is insufficient, degrade visibly: auto only when unique, choices when plural, queued when unattended.
- **Fetch-verification when the act carried it** — a verification descriptor (hash, expected property, epistemic bound) is checked, and divergence surfaces before consequences.
- **Weak resolution is disclosed.** When resolution succeeded via a *weaker* descriptor than the strongest one the act carried (the strong one dangled, the fallback matched), the outcome is **found-but-weakly**, never a clean hit — otherwise [[term/over-determination|over-determination]] quietly re-creates the silent near-miss it exists to kill. The same fail-safe philosophy as `$partial-key` at recognition time, applied at resolution time.
- **Zero only from a completed perspective.** An engine answers "empty set" only from a perspective it can attest is complete; against a still-filling perspective the outcome is the distinct **found-none-so-far**. A premature zero is not an answer to the question that was asked, and — since misses are the teaching channel — it actively mis-teaches.

## Epistemic Status

Definitional for the cardinality vocabulary and the engine/perspective split; the obligations list is a *formulation* — a chosen contract, argued from the fetch seams rather than derived. Obligations five and six were adopted deliberately (DECISIONS [[DECISIONS#d6-found-but-weakly|D6 found-but-weakly]], [[DECISIONS#d7-completed-perspective|D7 completed-perspective]] — ratified), with mixed provenance worth keeping distinct: found-but-weakly rests on this corpus's own `$partial-key` doctrine plus a **[verified]** external anchor (Phelps–Wilensky's measured re-anchoring-with-confidence); completed-perspective rests on the Fetch Assumption's own logic, with the Kahn-premise connection (formalisms survey §3) as corroborating dress at **[recall]** tier — the warrant is ours, the dress is theirs.

## Discussion

The double bound is the theory's most operationally consequential piece: it converts the classic silent failure modes (wrong count, stale model, hallucinated layout) into graduated dialogue at the act site, and its accumulated records are a free calibration corpus. The engine/perspective split is what later lets "filesystem-aware" vs "logical-only" be two policies over one tree rather than two address languages — the load-bearing move the reference-act IR builds on (Part II).

Terms defined here: [[term/expected-cardinality]], [[term/operational-bound]], [[term/epistemic-bound]], [[term/resolution-engine]], [[term/perspective]].

## Working Notes

- Open on the sixth obligation: what "attest is complete" means per perspective kind (a store with a declared membrane can attest; a glob over a live directory arguably cannot) — the attestation mechanics belong with the DON/engine design, not here.
