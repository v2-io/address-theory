---
slug: def-cardinality-and-resolution
form: definition
type-expected: definition
status: axiomatic
max: axiomatic
state: [drafted]
depends: [def-descriptors]
---

# Definition: Expected Cardinality, Engines, and Perspectives

A reference act carries an expected cardinality that gives a miss its meaning; resolution is performed by an engine relative to a perspective, and every engine owes the actor four things.

## Formal Expression

*[Definition (expected-cardinality)]* A reference act carries — implicitly or explicitly — an **EXPECTED CARDINALITY**: how many referents the actor means to pick out. This is part of the act's *type*, knowable before any resolution happens, and it is what gives a miss its meaning:

- Under expect-**exactly-one** ({1,1}), zero or several is a *loud failure* — the actor's model of the world is wrong, and they need to know.
- Under expect-**maybe-one** ({0,1}), zero is an *answer*: absent.
- Under expect-**any-number** ({0,N}), zero is an *answer*: empty set.
- Under expect-**at-least-one** ({1,N}), only zero is a failure.

Same descriptors, same world, four different meanings of the same result — the bound is what disambiguates. Designators default to {1,1}; descriptions have no natural default, which is why unstated bounds on descriptions are where surprises live — the wikilink stem-collision is an unstated-{1,1} violated.

*[Definition (double-bound)]* There are really **two bounds with different jobs**, usually conflated: the *operational* bound (how many the act will touch — "change the first," "take them all") and the *epistemic* bound (how many the actor believes exist — "I expect no more than three, or I've grossly misunderstood the data"). Divergence from the operational bound is failure; divergence from the epistemic bound is *information* — ideally a dialogue ("several exceed three — proceed anyway?"), not a binary error. Recorded epistemic bounds are also calibration data for free: what actors believed about the corpus, checked against reality at every act.

*[Definition (engine-and-perspective)]* Resolution is not a property of the reference act — it is performed by a **RESOLUTION ENGINE** relative to a **PERSPECTIVE** (an origin, a scope, a moment, a policy about what counts as the world). The same act may legitimately resolve differently under different engines: against the logical corpus ignoring document boundaries, against the filesystem layout, against the state as-of a moment, against one declared store's population. This is not ambiguity to eliminate — it is progressive routing's structure ( [[def-locations-and-paths]]): *someone* must own each hop, and the engine is the composite owner.

*[Formulation (engine-obligations)]* What every engine owes the actor, regardless of perspective (these follow from the Fetch Assumption's seams — [[disc-fetch-and-overdetermination]] — not from taste):

- **Typed outcomes even on failure** — found-one / found-many (with the candidates) / found-none / found-but-stale — because each routes to a different repair, and collapsing them teaches the actor nothing.
- **The requested descriptors preserved beside the result** — some consumers need what was asked, some need what was found; discarding either destroys information the act carried.
- **Never a silent best-guess.** Where narrowing is insufficient, degrade visibly: auto only when unique, choices when plural, queued when unattended.
- **Fetch-verification when the act carried it** — a verification descriptor (hash, expected property, epistemic bound) is checked, and divergence surfaces before consequences.

## Epistemic Status

Definitional for the cardinality vocabulary and the engine/perspective split; the obligations list is a *formulation* — a chosen contract, argued from the fetch seams rather than derived. Candidate fifth and sixth obligations are on record from the formalisms survey (found-but-weakly as a typed outcome; zero-answers only from attestably-complete perspectives) — held in Working Notes pending adoption, not silently folded in.

## Discussion

The double bound is the theory's most operationally consequential piece: it converts the classic silent failure modes (wrong count, stale model, hallucinated layout) into graduated dialogue at the act site, and its accumulated records are a free calibration corpus. The engine/perspective split is what later lets "filesystem-aware" vs "logical-only" be two policies over one tree rather than two address languages — the load-bearing move the reference-act IR builds on (Part II).

Feeds the lexicon: [[term/expected-cardinality]], [[term/operational-bound]], [[term/epistemic-bound]], [[term/resolution-engine]], [[term/perspective]].

## Working Notes

- Survey-sourced candidates for the obligations list (formalisms survey §8, §3 + finding 5, `[recall]`/`[verified]` register as marked there): **found-but-weakly** (resolution succeeded via a weaker descriptor than the strongest carried — say so; `$partial-key` is the same doctrine at recognition time) and **zero only from a completed perspective** (an empty-set answer from a still-filling store is a non-blocking read — return found-none-so-far as a distinct outcome). Adopt deliberately, not by drift.
