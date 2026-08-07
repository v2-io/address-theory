---
slug: disc-fetch-and-overdetermination
form: discussion
type-expected: discussion
status: discussion-grade
max: robust-qualitative
state: [drafted]
depends: [def-descriptors, def-cardinality-and-resolution]
---

# Discussion: The Fetch Assumption and Over-Determination

Making the implicit resolve-then-GET assumption explicit exposes the seams the machinery must serve; and descriptors past the minimum are not redundancy but verification.

## The Fetch Assumption

There is an implicit assumption running under all addressing: that when we have identified the object correctly, we **GET / fetch** the thing — and therefore have its *full description* become available. Making it explicit exposes the seams:

- **Reference acts that stop before the fetch** are real and common: citing, verifying existence, reserving a name, handing an address to someone else. The descriptors are doing their job with no GET at all — which means the design cannot treat "resolves" and "fetches" as one step.
- **Identification can succeed while fetch fails** — Santa Claus is distinctly identified; the path to him is fraught with danger. (An identity in hand, no route.)
- **Fetch can succeed on the wrong referent** when narrowing was insufficient *and nothing travels with the address to verify against* — the ambiguous package, delivered anyway, arrives at the wrong Joseph *silently*. A verification descriptor riding along (a content fingerprint, an expected property) converts a silent mis-fetch into a loud one. **This is the first-principles argument for addresses that can carry an expectation.**
- **What a fetch returns is a description, not the thing.** Fetching an entity ( [[def-entities-values-promises]]) hands you its description *as of now*. You never hold the entity; you hold a snapshot. Much confusion about caching, staleness, and "is this still true?" is this distinction ignored.

## Over-Determination

Conjunction has a second job beyond narrowing: **over-determination**. Descriptors past the minimum needed to reach one referent aren't redundant — they are *verification* (if two co-referring descriptors disagree at resolution time, something moved or the actor's model is stale — a loud contradiction instead of a silent wrong answer) and *redundant routes* (resolve by whichever descriptor this resolver's community happens to know). The mail system uses the zip AND the city/state spelled out for exactly both reasons.

## Epistemic Status

Discussion-grade argumentation over the Part I definitions; the individual seam observations are each independently checkable against lived systems, and the over-determination mechanism has direct engineering ancestry (robust-anchoring selector stacks — Part III's [[form-anchoring-ladder]] row). Max `robust-qualitative` if the seams are systematically instanced.

## Working Notes

- The engine obligations ( [[def-cardinality-and-resolution]]) cite these seams as their ground — if a seam is revised here, the obligations list re-verifies.
