---
slug: def-entities-values-promises
form: definition
type-expected: definition
status: axiomatic
max: axiomatic
state: [drafted]
depends: [def-descriptors, def-locations-and-paths]
---

# Definition: Entities, Value Objects, and the Four Promises

An entity's identity is independent of its description; a value object is its description — and "canonical" names four different promises that must not be conflated.

## Formal Expression

*[Definition (entity; value-object)]* Borrowing the standard vocabulary, defined precisely for our purposes:

- An **ENTITY** is a thing whose identity is independent of its current description. It persists through change — the document after the edit is *the same document*; Joseph at 8 and Joseph now are the same Joseph. Because nothing in its content can testify to its identity, an entity's identity must be **minted and maintained by convention** — a designator plus a naming community that keeps the binding. Entities are what designators are *for*.
- A **VALUE OBJECT** is a thing that *is* its description. The number 47, the string "hello", the exact bytes of a file at a moment. Two value objects with the same content are not similar — they are the same, and "which one" is a meaningless question. A value object cannot dangle, cannot be renamed, and cannot change (a "changed" value object is a different value object).

*[Derived (addressing-consequences)]* Consequences that fall out rather than being designed:

- **Entities admit identity-addressing and require it** if you mean *it-through-change*. Any content-derived handle to an entity silently becomes a handle to a value object — a snapshot — the moment the entity changes.
- **Value objects admit exactly two addressings**: by complete description — and a cryptographic hash is precisely a *complete description compressed into designator shape*, which is why content addressing feels like identity and description at once; the two genuinely collapse here, by nature rather than by sloppiness — or by **role**: "the value of `:status` on `intent[311]`" names a *slot on an entity*, and what occupies the slot is a value object that changes by replacement.
- The mutable/immutable pairing every mature system reinvents is this split made operational: git's refs (entity designators, re-bindable) over blobs (value objects, content-addressed); IPNS over IPFS; a database row's key over its cell values.
- For our documents specifically: a record is an entity; its serialized content at any commit is a value object; and the recurring question "same document or not?" is almost always the question *which of the two did the reference mean* — usually asked too late, after an address form was chosen that could only express one of them.

*[Definition (the-four-promises)]* "Canonical" is used for at least four different things, and conflating them costs exactly the confusion the word exists to prevent. Working names, each defined by what is being **promised** and by whom:

| Term | What it is | The promise |
|---|---|---|
| **TRUE IDENTITY** | The designator that names the entity itself — whether or not anything can currently be fetched with it | "This names *it*." Held by the minting community; independent of routability |
| **CANONICAL LOCATION** | The preferred universal location, promised permanent | "This will keep resolving." A standing commitment by the naming authority — breaking it is a breach, not an event |
| **PREFERRED LOCATION** | The currently best universal location, no permanence promised | "This resolves today, and it's the one we'd rather you use." May be superseded without breach |
| **WORKING PATH** | Whatever route works from here, now — often origin-relative, often abbreviated | No promise at all; a convenience of the current context, expected to expire with it |

The differences are differences in *promise*, which makes canonicity **social** — the same family of convention that binds designators to referents — not a property of the strings. A design that lets a stored reference say *which of the four it is* lets a reader know what may be relied on without resolving anything; a design that doesn't forces every reader to guess, and the guesses are where the failures live.

## Epistemic Status

Definitional throughout; the addressing consequences are derived from the definitions (marked). The claim that canonicity is social is definitional given the promise-based carve — the carve itself is the contribution.

## Discussion

The entity/value-object split and the promise table compose: a stored reference to an entity via TRUE IDENTITY survives everything but community collapse; via WORKING PATH it survives nothing but the current context. Fetch-verification pins ( [[def-cardinality-and-resolution]]) are value-object descriptors riding on entity references — the composition that converts silent staleness into loud divergence.

Feeds the lexicon: [[term/entity]], [[term/value-object]], [[term/true-identity]], [[term/canonical-location]], [[term/preferred-location]], [[term/working-path]].

## Working Notes

- Editor note carried from the source at split time: an IPFS/IPNS treatment removed from an earlier draft belongs in the mutable/immutable bullet once this section settles — the one-line version currently stands in for it.
