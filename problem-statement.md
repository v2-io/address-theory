# Problem Statement

Generally speaking paths and references weave their way through every aspect of Udon and the greater Udon ecosystem, both realized and planned. This document is for putting together the primary seams and concerns so that we can work on it in its simplicity but ensure that all aspects and concerns are properly represented.

## Basic Foundations

### Reference Acts & Descriptors 

**A 'REFERENCE ACT' supplies 'DESCRIPTORS' that narrow the world down to one intended 'REFERENT'.** The primary items below — identity, location, path — are the first descriptors we define with precision for our purposes here.

*(Example: A mailing address 'REFERENCE ACT' with DESCRIPTORs looking for a single person (the REFERENT) as mail is assumed to be delivered only once to one recipient person)*
```
Joseph          <- IDENTITY   (Target, partial)
123 North St.   <- LOCATION   (most detailed, but missing apartment no.)
Citee, NY 11111 <- LOCATIONx3 (more general, except zip & state switch)
USA             <- LOCATION   (most general)
```

In the postal example here, each line of the address strips away candidates. "USA" removes most of the world; "NY" most of the USA; the street most of the zip; "Joseph" most of the household. A real incident makes the mechanism visible: a package was refused at the shipping counter — *"the address you gave us is ambiguous and there are several people by that name it might end up with"* — because one missing digit left the descriptor conjunction narrowing to *several* referents instead of one. Ambiguity is not a special error; it is what insufficient narrowing *is*.

We define here two kinds of descriptor, distinguished by **what connects the descriptor to its referent** — an agreement, or a fact. A designator is attached by *agreement*: someone bound the name to the thing, and that binding is the whole connection (the referent's own properties are irrelevant to it). A description is attached by *fact*: nothing was ever bound; the connection is re-computed, every time it is used, from whatever currently satisfies the predicate. The distinction is important because the two connections break differently:

- **DESIGNATOR** — a minted name, bound to its referent by convention: "Joseph", a filename, a bibkey, a UUID, a slug. Its meaning is held by a naming community (a family, a filesystem, a registry), not by the referent's properties. A designator's failure modes: it can **dangle** (the convention forgets or never knew), or **collide** (two mints, one name).
- **DESCRIPTION** — a predicate the world satisfies: "the resident aged 47", a glob, a `WHERE` clause, "every element with trait `canon`", "the file whose stem is `atom`". A description designates *whatever currently satisfies it* — zero, one, or many, and that plurality is a feature. Its distinctive failure mode is **silent re-satisfaction**: the world changes, the same words now pick out something else, and nothing signals the change.

Most real addresses are conjunctions mixing both kinds. "Joseph" (designator) + "123 North St, 11111" (containment descriptors) is a mixed conjunction whose *joint* narrowing is what matters. This is also where partial identity gets its precise footing: "Joseph" alone is not a weak description — it is a perfectly good designator whose *naming community is too large for the job*.

Conjunction has a second job beyond narrowing: **over-determination**. Descriptors past the minimum needed to reach one referent aren't redundant — they are *verification* (if two co-referring descriptors disagree at resolution time, something moved or the actor's model is stale — a loud contradiction instead of a silent wrong answer) and *redundant routes* (resolve by whichever descriptor this resolver's community happens to know). The mail system uses the zip AND the city/state spelled out for exactly both reasons.

### Location vs Identity

Usually addressing a document consists of some combination of *known LOCATION components* and *known IDENTITY components* — as in the mailing address above: one identity component ("Joseph") conjoined with a stack of location components.

If the identity is already unique enough to distinctly identify the right thing, location isn't required if the "thing" is what you want (e.g., "Santa Clause, North Pole", or "google.com").

Other times the Address or LOCATION *is* the thing — when you are driving to an address, for example, after which you'll worry about what's there.

In descriptor terms: IDENTITY components are designators for the target itself; LOCATION components are descriptors of a particular, powerful family — **containment coordinates**, each one a designator *for a container*, arranged so that the containers nest. That family is powerful because containers can **route** (below), which plain identity cannot.

A reduction worth having on the table, held lightly: a LOCATION may not be primitive — it looks like *an identity embedded in a resolvable containment hierarchy* ("123 North St" is the identity of a street; the chain of containers is what makes it routable). Under that reduction, UNIVERSAL LOCATION (below) becomes a theorem: an identity whose container chain resolves from anywhere. The caveat that keeps the working vocabulary anyway: the elegance may be offset by the heterogeneity of the things — collapsing the two loses the practical affordance of the difference between *an intermediate location* and *the thing you're after*, and that difference does daily work. So: one underlying kind, two working roles, both kept.

### Path

Then there is the *PATH*. In the digital world, it is often assumed to be interchangeable with the LOCATION, but it might be wise for us to distinguish it better using its physical model: One set of possibly many (so it may not be unique) monotonic steps between an *origin LOCATION* and a *destination LOCATION*. It might be reversible/symmetric or only defined one direction, it may be unique or one of an infinite many, or it might be one of many but the shortest. The intermediate steps might themselves be *intermediate LOCATIONs*. So when a path is referring to a destination, the source is *usually* "wherever you are." From your web browser to the document, etc. Other times it's explicit but shorthand, for example, filesystems usually have a designation for the filesystem root '/...' meaning starting from the root, and when it is missing, it is usually implied "from wherever you are" or the current working directory. And then there are some other sigils/glyph-prefixes like "~name/..." means the home directory for 'name', and "~/..." means the home directory for whoever you are right then as the beginning point.

It is very easy to conflate: IDENTITY, LOCATION, and PATH. That's especially true because they can overlap in certain situations. For example, the address pieces in the contrived example above *could* be considered a "logical" path from anywhere: From anywhere in the world I can first go to the USA. Once there, I can then go to New York, once there I can go to the 11111 zip code area. And so forth. So it might be meaningful for us to nail down another term here: *UNIVERSAL LOCATION* — A *LOCATION* that, due to full specificity, can be used as an effective PATH from anywhere to that location, because the components of the location progressively resolve from anywhere to the destination. It could also be said it is a *PATH* with a *UNIVERSAL ORIGIN*.

Note this explains, rather than merely observes, the URI/URN/URL conflation of path, destination, and identity: the "Universal" in those names is precisely the presupposition of UNIVERSAL LOCATION, which is exactly the condition under which the three interchange safely.

While there may be infinite paths to a LOCATION even from a single origin LOCATION, there may be a *CANONICAL LOCATION* or preferred location that may or may not be guaranteed to remain the same, which usually means it is a *UNIVERSAL LOCATION*, and therefore can also be expressed as a *CANONICAL PATH*. (This "canonical" is doing several jobs at once — unpacked in *Canonicity, precisely*, below.)

Paths themselves, whether they assume a LOCAL/LOCATION origin or a global/universal origin, are usually "resolved" or routed progressively at each intermediate step. So that *INTERMEDIATE LOCATION* is in charge of routing from there. Only that item is expected to be able to know how to route to the next item in the path. That also means that paths almost by definition are *LOGICAL PATH*s by default, and any *PHYSICAL PATH* equivalence is by construction and intentional (and a bit rare).

Progressive routing is worth dwelling on for one more sentence, because it quietly generates most of the machinery this design will need: if each intermediate owns only its next hop, then re-binding one intermediate re-routes every path through it (one mapping absorbs a physical move); a default at an intermediate is a routing choice (a bare name collapsing to a fuller one); and "resolution" as a whole is just the composite of these per-hop responsibilities.

### Why sequence appears at all — three causes, one costume

"PATHWISE" (sequential) is not one thing. A sequence of components appears in an address for three different reasons, and the imperative-vs-declarative character of a segment is a *derived property of its cause*, not a primitive:

1. **Subset-sequence** — `chapter 3 / code 1`, `v2.io / asf / term / GUC`: the order mirrors *containment*; each component is a subset of the previous. Semantically a **nested conjunction wearing a path costume**: the order is derivable (by generality), stepwise resolution is *available* ("each intermediate knows how to route the next" is true precisely because each subsequent location is a subset of its parent) but not *required*. Declarative in nature, imperative-executable. **This is the general law behind the path/location/destination conflation** — a subset-chain genuinely is both at once; UNIVERSAL LOCATION was its special case.
2. **Resolver-sequence** — `dns-lookup('v2.io') / ssh(22) / cd ~ / find …`: each step's *output* feeds a different resolver; heterogeneous, possibly stateful, order essential. Truly imperative; irreducible in general.
3. **Compositional (offset) sequence** — `down 7 / left 3 / up -2`: steps are transforms that compose. **Reducible iff the consumer wants only the endpoint and composition is associative** (fold the vectors) — and NOT reducible when the path itself is the product ("if you're drawing lines"). Corollary the model needs: sometimes the referent *is the route* — provenance trails, derivations, traversals-as-data — and reduction is then destruction.

Real addresses are heterogeneous chains mixing all three (a scheme-hop, then globs, then containment steps), so the cause is a property of the *segment*, not the address. The payoff of marking it: **the sequence-cause is exactly what a resolution engine may optimize** — subset-sequences reorder and fuse (they are conjunctions; this is what query planners exploit), compositional sequences fold when endpoint-only, resolver-sequences are pipeline barriers.

### The Fetch Assumption

There is an implicit assumption running under all of the above that we should make explicit: we use a location or path or identity or some combination with the implicit assumption that when we have identified the object correctly, we **GET / fetch** the thing (or document) — and therefore have its *full description* become available (with nuance).

Making it explicit exposes the seams:

- **Reference acts that stop before the fetch** are real and common: citing, verifying existence, reserving a name, handing an address to someone else. The descriptors are doing their job with no GET at all — which means the design cannot treat "resolves" and "fetches" as one step.
- **Identification can succeed while fetch fails** — Santa Claus is distinctly identified; the path to him is fraught with danger. (An identity in hand, no route.)
- **Fetch can succeed on the wrong referent** when narrowing was insufficient *and nothing travels with the address to verify against* — the ambiguous package, delivered anyway, arrives at the wrong Joseph *silently*. A verification descriptor riding along (a content fingerprint, an expected property) converts a silent mis-fetch into a loud one. This is the first-principles argument for addresses that can carry an expectation.
- **What a fetch returns is a description, not the thing.** Fetching an entity (next section) hands you its description *as of now*. You never hold the entity; you hold a snapshot. Much confusion about caching, staleness, and "is this still true?" is this distinction ignored.

### Expected Cardinality

A reference act carries — implicitly or explicitly — an **expected cardinality**: how many referents the actor means to pick out. This is part of the act's *type*, knowable before any resolution happens, and it is what gives a miss its meaning:

- Under expect-**exactly-one** ({1,1}), zero or several is a *loud failure* — the actor's model of the world is wrong, and they need to know.
- Under expect-**maybe-one** ({0,1}), zero is an *answer*: absent.
- Under expect-**any-number** ({0,N}), zero is an *answer*: empty set.
- Under expect-**at-least-one** ({1,N}), only zero is a failure.

Same descriptors, same world, four different meanings of the same result — the bound is what disambiguates. (Designators default to {1,1}; descriptions have no natural default, which is why unstated bounds on descriptions are where surprises live — the wikilink stem-collision is an unstated-{1,1} violated.)

There are really **two bounds with different jobs**, usually conflated: the *operational* bound (how many the act will touch — "change the first," "take them all") and the *epistemic* bound (how many the actor believes exist — "I expect no more than three, or I've grossly misunderstood the data"). Divergence from the operational bound is failure; divergence from the epistemic bound is *information* — ideally a dialogue ("several exceed three — proceed anyway?"), not a binary error. Recorded epistemic bounds are also calibration data for free: what actors believed about the corpus, checked against reality at every act.

### Resolution: Engines and Perspectives

Resolution is not a property of the reference act — it is performed by a **RESOLUTION ENGINE** relative to a **PERSPECTIVE** (an origin, a scope, a moment, a policy about what counts as the world). The same act may legitimately resolve differently under different engines: against the logical corpus ignoring document boundaries, against the filesystem layout, against the state as-of a moment, against one declared store's population. This is not ambiguity to eliminate — it is the same structure as progressive routing above: *someone* must own each hop, and the engine is the composite owner.

What every engine owes the actor, regardless of perspective (these follow from the Fetch Assumption's seams, not from taste):

- **Typed outcomes even on failure** — found-one / found-many (with the candidates) / found-none / found-but-stale — because each routes to a different repair, and collapsing them teaches the actor nothing.
- **The requested descriptors preserved beside the result** — some consumers need what was asked, some need what was found; discarding either destroys information the act carried.
- **Never a silent best-guess.** Where narrowing is insufficient, degrade visibly: auto only when unique, choices when plural, queued when unattended.
- **Fetch-verification when the act carried it** — a verification descriptor (hash, expected property, epistemic bound) is checked, and divergence surfaces before consequences.

### Entity vs Value Object

Borrowing the standard vocabulary, defined precisely for our purposes:

- An **ENTITY** is a thing whose identity is independent of its current description. It persists through change — the document after the edit is *the same document*; Joseph at 8 and Joseph now are the same Joseph. Because nothing in its content can testify to its identity, an entity's identity must be **minted and maintained by convention** — a designator plus a naming community that keeps the binding. Entities are what designators are *for*.
- A **VALUE OBJECT** is a thing that *is* its description. The number 47, the string "hello", the exact bytes of a file at a moment. Two value objects with the same content are not similar — they are the same, and "which one" is a meaningless question. A value object cannot dangle, cannot be renamed, and cannot change (a "changed" value object is a different value object).

Consequences for addressing, which fall out rather than being designed:

- **Entities admit identity-addressing and require it** if you mean *it-through-change*. Any content-derived handle to an entity silently becomes a handle to a value object — a snapshot — the moment the entity changes.
- **Value objects admit exactly two addressings**: by complete description — and a cryptographic hash is precisely a *complete description compressed into designator shape*, which is why content addressing feels like identity and description at once; the two genuinely collapse here, by nature rather than by sloppiness — or by **role**: "the value of `:status` on `intent[311]`" names a *slot on an entity*, and what occupies the slot is a value object that changes by replacement.
- The mutable/immutable pairing that every mature system reinvents is this split made operational: git's refs (entity designators, re-bindable) over blobs (value objects, content-addressed); IPNS (a minted name that re-points) over IPFS (content addresses); a database row's key over its cell values. *(The IPFS/IPNS treatment removed from an earlier draft belongs here once this section settles.)*
- For our documents specifically: a record is an entity; its serialized content at any commit is a value object; and the recurring question "same document or not?" is almost always the question *which of the two did the reference mean* — usually asked too late, after an address form was chosen that could only express one of them.

### Canonicity, precisely

"Canonical" is used for at least four different things, and conflating them costs exactly the confusion the word exists to prevent. Working names, each defined by what is being **promised** and by whom:

| Term | What it is | The promise |
|---|---|---|
| **TRUE IDENTITY** | The designator that names the entity itself — whether or not anything can currently be fetched with it | "This names *it*." Held by the minting community; independent of routability |
| **CANONICAL LOCATION** | The preferred universal location, promised permanent | "This will keep resolving." A standing commitment by the naming authority — breaking it is a breach, not an event |
| **PREFERRED LOCATION** | The currently best universal location, no permanence promised | "This resolves today, and it's the one we'd rather you use." May be superseded without breach |
| **WORKING PATH** | Whatever route works from here, now — often origin-relative, often abbreviated | No promise at all; a convenience of the current context, expected to expire with it |

The differences are differences in *promise*, which makes canonicity social — the same family of convention that binds designators to referents — not a property of the strings. A design that lets a stored reference say *which of the four it is* lets a reader know what may be relied on without resolving anything; a design that doesn't forces every reader to guess, and the guesses are where the failures live.

### Brief Survey

**Common Location Components (Digital)**:[^1]  
Often with Location elements, or "Addresses," in a given format, the components are positional (e.g., Street -> City -> State, Postal Code, Country)
- Server: Either name (for dns) or address (IP address) and implicit or explicit port. (itself a location vs named identity decision)
- Location (note the URI/URN/URL possible conflation of path, destination, and identity. That's due to the "Universal..." in the names — meaning they presuppose or assume *UNIVERSAL LOCATION* and therefore interchange w/ *PATH* etc. safely):
    - Namespace+: Hierarchy of namespaces, such as NID + NSS in typical URNs.
    - Path+: Hierarchy of (logical) containers — sometimes mapping directly to filesystem directories

**Common Identity Components**
- "Identifier": Often included simply as the last element of the path in URIs, or the last thing on a filesystem path — the "file-name" which is sometimes a directory-type file, so an intermediate location otherwise.
- {Server -> DB -> Table -> *Surrogate Key*} (unique only all together)
- {Server -> DB -> Table -> *Natural Key*} (sometimes unique all together, sometimes natural key + table alone, etc.)
- {*UUID*} Universally Unique ID. Just super ugly. Several versions with different tradeoffs (e.g., lexical sorting, generating speed, etc.). A pure *UNIVERSAL IDENTITY*, like Santa Clause, may be enough to distinctively identify something, but unlike Santa Clause, by itself its location might not be known, and like with Santa Clause, the path to it might be fraught with danger.

**Common Description Components** (the third mode, usually unlabeled in the wild)
- Predicate filters: SQL `WHERE`, CSS selector classes/pseudo-classes, XPath predicates `[...]`, attribute/trait filters.
- Patterns over names: globs, stem-matching (wikilinks resolve by stem-match over a scope — a description wearing a designator's clothes, which is why stem collisions surprise people).
- Content addresses: the limiting case where the description is complete and compressed to fixed size (hash) — see Entity vs Value Object.

[^1]: Notably absent for our purposes that is sometimes part of a URL: Scheme, Authentication, Filetype (identifier '.xyz' suffix that is shorthand for the data type or document type usually).
