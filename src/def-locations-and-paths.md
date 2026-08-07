---
slug: def-locations-and-paths
form: definition
type-expected: definition
status: axiomatic
max: axiomatic
state: [drafted]
depends: [def-descriptors]
---

# Definition: Locations, Identity, and Paths

Identity components designate the target itself; location components are containment coordinates; a path is a set of monotonic steps between locations — and keeping the three distinct, while knowing exactly when they safely interchange, is this segment's whole job.

## Formal Expression

*[Definition (identity-vs-location)]* Addressing usually conjoins *known IDENTITY components* with *known LOCATION components*. In descriptor terms ( [[def-descriptors]]): **IDENTITY components** are designators for the target itself; **LOCATION components** are descriptors of a particular, powerful family — **containment coordinates**, each one a designator *for a container*, arranged so that the containers nest. That family is powerful because containers can **route**, which plain identity cannot. If identity is already unique enough, location isn't required ("Santa Claus, North Pole"; "google.com"); other times the location *is* the thing (driving to an address, after which you'll worry about what's there).

*[Formulation (the reduction, held lightly)]* A LOCATION may not be primitive — it looks like *an identity embedded in a resolvable containment hierarchy* ("123 North St" is the identity of a street; the chain of containers is what makes it routable). Under that reduction, UNIVERSAL LOCATION becomes a theorem: an identity whose container chain resolves from anywhere. The caveat that keeps the working vocabulary anyway: collapsing the two loses the practical affordance of the difference between *an intermediate location* and *the thing you're after*, and that difference does daily work. **One underlying kind, two working roles, both kept.**

*[Definition (path)]* A **PATH** is one set of possibly many (so, not necessarily unique) monotonic steps between an *origin LOCATION* and a *destination LOCATION*. It may be reversible or one-directional; unique, one of infinitely many, or the shortest of many. Intermediate steps may themselves be *INTERMEDIATE LOCATIONs*. The origin is *usually* "wherever you are"; sometimes explicit shorthand (filesystem `/` = from root; `~name/` = from a named home). Paths are *LOGICAL PATHs* by default; any *PHYSICAL PATH* equivalence is by construction and intentional.

*[Definition (universal-location)]* A **UNIVERSAL LOCATION** is a LOCATION that, due to full specificity, can be used as an effective PATH from anywhere — its components progressively resolve from anywhere to the destination. Equivalently: a PATH with a *UNIVERSAL ORIGIN*. This *explains*, rather than merely observes, the URI/URN/URL conflation of path, destination, and identity: the "Universal" in those names is precisely the presupposition of UNIVERSAL LOCATION, which is exactly the condition under which the three interchange safely.

*[Derived (progressive-routing)]* Paths are resolved progressively: each *INTERMEDIATE LOCATION* is in charge of routing from there — only that item is expected to know how to route to the next. Dwelling one sentence, because this quietly generates most of the machinery the design needs: if each intermediate owns only its next hop, then **re-binding one intermediate re-routes every path through it** (one mapping absorbs a physical move); **a default at an intermediate is a routing choice** (a bare name collapsing to a fuller one); and **"resolution" as a whole is just the composite of these per-hop responsibilities**.

## Epistemic Status

Definitional, with one marked formulation (the reduction — held lightly by design) and one derived consequence (progressive routing's three corollaries, which follow from the per-hop ownership structure). The conflation-explanation for URIs is an explanatory claim earned by the UNIVERSAL LOCATION definition, not an independent assertion.

## Discussion

It is very easy to conflate IDENTITY, LOCATION, and PATH — especially because they genuinely overlap in the universal-location case, where a fully-specified location *is* a path from anywhere and often *carries* the identity as its last component. The vocabulary here exists so that the overlap is a stated condition rather than an ambient blur. There may be a *CANONICAL LOCATION* among the many; what "canonical" promises is deliberately deferred to [[def-entities-values-promises]], where it is unpacked into four distinct promises. Why sequences appear in addresses at all — and why some are reorderable while others are not — is [[claim-sequence-causes]].

Feeds the lexicon: [[term/identity-component]], [[term/location]], [[term/containment-coordinate]], [[term/path]], [[term/universal-location]], [[term/intermediate-location]], [[term/progressive-routing]].
