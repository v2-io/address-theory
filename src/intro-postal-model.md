---
slug: intro-postal-model
form: discussion
type-expected: discussion
status: discussion-grade
max: discussion-grade
state: [drafted]
depends: []
---

# Introduction: The Postal Model

A mailing address is a reference act in miniature — every load-bearing concept in this theory is visible in one, before any formalism.

**A reference act supplies descriptors that narrow the world down to one intended referent.** A mailing address is a reference act whose descriptors look for a single person (the referent), since mail is assumed to be delivered only once, to one recipient:

```text
Joseph          <- IDENTITY   (Target, partial)
123 North St.   <- LOCATION   (most detailed, but missing apartment no.)
Citee, NY 11111 <- LOCATIONx3 (more general, except zip & state switch)
USA             <- LOCATION   (most general)
```

Each line of the address strips away candidates. "USA" removes most of the world; "NY" most of the USA; the street most of the zip; "Joseph" most of the household. A real incident makes the mechanism visible: a package was refused at the shipping counter — *"the address you gave us is ambiguous and there are several people by that name it might end up with"* — because one missing digit left the descriptor conjunction narrowing to *several* referents instead of one. **Ambiguity is not a special error; it is what insufficient narrowing *is*.**

Most real addresses are conjunctions mixing descriptor kinds: "Joseph" (a designator) plus "123 North St, 11111" (containment descriptors) is a mixed conjunction whose *joint* narrowing is what matters. The formal treatment of the kinds begins at [[def-descriptors]]; the address's own anatomy — identity, location, path — at [[def-locations-and-paths]]. The postal model returns throughout: the mis-delivered package for the Fetch Assumption's seams ( [[disc-fetch-and-overdetermination]]), the zip-AND-city redundancy for over-determination, and Santa Claus for identity-without-route.

## Working Notes

- This segment must stay first in any view — it is the load-bearing on-ramp; every later definition leans on the postal vocabulary it establishes (coherence review, split-time).
- Cadence-exempt (intro segment): no Formal Expression / Epistemic Status sections by design.
