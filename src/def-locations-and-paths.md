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

*[Definition (identity-vs-location)]* Addressing usually conjoins *known IDENTITY components* with *known LOCATION components*. In descriptor terms ( [[def-descriptors]]): **IDENTITY components** are designators for the target itself. A **LOCATION** is a descriptor of one precise anatomy (re-carved D12): **a containment predicate over a designated container** — "contained-in C," where C is held by a **CONTAINMENT COORDINATE** (a designator *for a container*). So the partition of [[def-descriptors]] survives cleanly: the coordinate (the container's *name*) is a **designator**; the location (the *being-in-it* claim) is a **description** — the one description family whose satisfier-set has an *owner*. Three properties distinguish it from free predicates, each doing standalone work: **(1) narrowing-by-region with subset semantics** — containment nests, so locations compose transitively (the ground of [[claim-sequence-causes]]'s subset-sequences); **(2) delegable resolution** — the container's community can enumerate and route within its contents, which is why progressive routing's per-hop ownership exists for this family alone; **(3) partial policing** — membership is community-witnessed, degrading more gracefully than an unowned predicate. Standing alone, a location is a **scope** (a region — what perspectives and store membranes are made of); composed, locations fill the path roles below. If identity is already unique enough, location isn't required ("Santa Claus, North Pole"); other times the location *is* the thing.

*[Derived (recursive-anatomy; descriptor-kind is per-act)]* Descriptor-kind is relative to the act under analysis, because resolution is recursive: each hop of narrowing is a sub-act, and a directory's name is a *designator in the hop-act* while the containment claim built from it is a *description in the enclosing act*. Consequence, stated as the theorem it is: **every resolvable descriptor chain bottoms out in designators** — only community bindings terminate the regress. The working altitudes remain clean (routing machinery / other narrowing / the referents themselves) precisely *because* they share the designator layer as atoms rather than smearing into each other.

*[Formulation (the reduction, held lightly)]* A LOCATION may not be primitive — it looks like *an identity embedded in a resolvable containment hierarchy* ("123 North St" is the identity of a street; the chain of containers is what makes it routable). Under that reduction, the UNIVERSAL PATH becomes a theorem: an identity whose container chain resolves from anywhere carries one. The caveat that keeps the working vocabulary anyway: collapsing the two loses the practical affordance of the difference between *an intermediate location* and *the thing you're after*, and that difference does daily work. **One underlying kind, two working roles, both kept.**

*[Definition (path)]* A **PATH** is one set of possibly many (so, not necessarily unique) monotonic steps between an *origin LOCATION* and a *destination LOCATION*. It may be reversible or one-directional; unique, one of infinitely many, or the shortest of many. Intermediate steps may themselves be *INTERMEDIATE LOCATIONs*. The origin is *usually* "wherever you are"; sometimes explicit shorthand (filesystem `/` = from root; `~name/` = from a named home). Paths are *LOGICAL PATHs* by default; any *PHYSICAL PATH* equivalence is by construction and intentional.

*[Definition (universal-path)]* A **UNIVERSAL PATH** (synonym: *absolute path*) is a PATH whose *origin is universal* — within a bounded resolution context, it routes to its destination from **any** origin, because its outermost step resolves from everywhere in that context. A fully-specified location often *carries* a universal path (its containment chain read from the root down), which is why the two are so easily conflated — but universality is a property of the **path** (origin-independence), never of the location it reaches. This *explains*, rather than merely observes, the URI/URN/URL conflation of path, destination, and identity: the "Universal" in those names is precisely the presupposition of a universal path, which is exactly the condition under which the three interchange safely. *(Naming note: this concept was "UNIVERSAL LOCATION" until 2026-08-08 — a designation that itself committed the path/location conflation this segment exists to prevent; re-carved D11.)*

*[Derived (progressive-routing)]* Paths are resolved progressively: each *INTERMEDIATE LOCATION* is in charge of routing from there — only that item is expected to know how to route to the next. Dwelling one sentence, because this quietly generates most of the machinery the design needs: if each intermediate owns only its next hop, then **re-binding one intermediate re-routes every path through it** (one mapping absorbs a physical move); **a default at an intermediate is a routing choice** (a bare name collapsing to a fuller one); and **"resolution" as a whole is just the composite of these per-hop responsibilities**.

## Epistemic Status

Definitional, with one marked formulation (the reduction — held lightly by design) and one derived consequence (progressive routing's three corollaries, which follow from the per-hop ownership structure). The conflation-explanation for URIs is an explanatory claim earned by the UNIVERSAL PATH definition, not an independent assertion.

## Discussion

It is very easy to conflate IDENTITY, LOCATION, and PATH — especially because they genuinely overlap in the universal-path case, where a fully-specified location *carries* a path from anywhere and often *carries* the identity as its last component. The vocabulary here exists so that the overlap is a stated condition rather than an ambient blur. There may be a *CANONICAL LOCATION* among the many; what "canonical" promises is deliberately deferred to [[def-entities-values-promises]], where it is unpacked into four distinct promises. Why sequences appear in addresses at all — and why some are reorderable while others are not — is [[claim-sequence-causes]].

Terms defined here: [[term/identity-component]], [[term/location]], [[term/containment-coordinate]], [[term/path]], [[term/universal-path]], [[term/intermediate-location]], [[term/progressive-routing]].

## Working Notes

- Steward sharpening (2026-08-08, ERD review): a path has **one of (explicit | implicit | universal) origin location, and one destination location** — the origin trichotomy stated crisply, where this segment's body holds it loosely ("usually 'wherever you are'; sometimes explicit shorthand"). The universal-path re-carve (D11, same day) then attached the concept to its correct bearer: a universal path IS a path whose origin is the third arm. Body text should absorb the trichotomy on next steward-verified pass; term entries carry it now (path→origin/destination relations, per the same review).
