---
slug: def-descriptors
form: definition
type-expected: definition
status: axiomatic
max: axiomatic
state: [drafted]
depends: [intro-postal-model]
---

# Definition: Reference Acts and Descriptors

A reference act supplies descriptors that narrow the world to one intended referent; descriptors come in two kinds, distinguished by what connects the descriptor to its referent — an agreement, or a fact.

## Formal Expression

*[Definition (reference-act)]* A **REFERENCE ACT** supplies **DESCRIPTORS** that narrow the world down to one intended **REFERENT**.

*[Definition (descriptor-kinds)]* Two kinds of descriptor, distinguished by **what connects the descriptor to its referent**. A designator is attached by *agreement*: someone bound the name to the thing, and that binding is the whole connection (the referent's own properties are irrelevant to it). A description is attached by *fact*: nothing was ever bound; the connection is re-computed, every time it is used, from whatever currently satisfies the predicate. The distinction matters because the two connections break differently:

- **DESIGNATOR** — a minted name, bound to its referent by convention: "Joseph", a filename, a bibkey, a UUID, a slug. Its meaning is held by a **naming community** (a family, a filesystem, a registry), not by the referent's properties. A designator's failure modes: it can **dangle** (the convention forgets or never knew), or **collide** (two mints, one name).
- **DESCRIPTION** — a predicate the world satisfies: "the resident aged 47", a glob, a `WHERE` clause, "every element with trait `canon`", "the file whose stem is `atom`". A description designates *whatever currently satisfies it* — zero, one, or many, and that plurality is a feature. Its distinctive failure mode is **silent re-satisfaction**: the world changes, the same words now pick out something else, and nothing signals the change.

*[Definition (mixed-conjunction; partial identity)]* Most real addresses are conjunctions mixing both kinds, and the *joint* narrowing is what matters. Partial identity gets its precise footing here: "Joseph" alone is not a weak description — it is a perfectly good designator whose *naming community is too large for the job*.

## Epistemic Status

Definitional; the vocabulary this corpus builds on. The designator/description cut is old philosophy of language wearing engineering clothes, deployed here for its failure-mode payoff (dangle/collide vs silent re-satisfaction), which is what the resolution machinery answers to.

## Discussion

The failure modes are the design drivers. Everything downstream — over-determination as verification ( [[disc-fetch-and-overdetermination]]), typed resolution outcomes, expected cardinality ( [[def-cardinality-and-resolution]]) — exists because these two connection kinds break in these specific ways. A design that treats a wikilink (a description by stem-match wearing a designator's clothes) as a designator inherits silent re-satisfaction it never priced; the survey rows in [[obs-address-components]] catalog the wild forms.

Feeds the lexicon: [[term/reference-act]], [[term/descriptor]], [[term/referent]], [[term/designator]], [[term/description]], [[term/naming-community]].
