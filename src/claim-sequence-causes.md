---
slug: claim-sequence-causes
form: claim
type-expected: derived
status: discussion-grade
max: robust-qualitative
state: [drafted]
depends: [def-locations-and-paths]
terms-required: [path, universal-path]
terms-relevant: [referent]
---

# Claim: Why Sequence Appears at All — Three Causes, One Costume

"Pathwise" (sequential) is not one thing: a sequence of components appears in an address for three different reasons, and the imperative-vs-declarative character of a segment is a derived property of its cause, not a primitive.

## Formal Expression

*[Claim (sequence-causes)]* Three causes:

1. **Subset-sequence** — `chapter 3 / code 1`, `v2.io / asf / term / GUC`: the order mirrors *containment*; each component is a subset of the previous. Semantically a **nested conjunction wearing a [[term/path|path]] costume**: the order is derivable (by generality), stepwise resolution is *available* ("each intermediate knows how to route the next" is true precisely because each subsequent location is a subset of its parent) but not *required*. Declarative in nature, imperative-executable. **This is the general law behind the path/location/destination conflation** — a subset-chain genuinely is both at once; the [[term/universal-path|UNIVERSAL PATH]] ( [[def-locations-and-paths]], re-carved [[DECISIONS#d11-universal-path|D11 universal-path]]) is its special case.
2. **Resolver-sequence** — `dns-lookup('v2.io') / ssh(22) / cd ~ / find …`: each step's *output* feeds a different resolver; heterogeneous, possibly stateful, order essential. Truly imperative; irreducible in general.
3. **Compositional (offset) sequence** — `down 7 / left 3 / up -2`: steps are transforms that compose. **Reducible iff the consumer wants only the endpoint and composition is associative** (fold the vectors) — and NOT reducible when the path itself is the product ("if you're drawing lines"). Corollary the model needs: sometimes the [[term/referent|referent]] *is the route* — provenance trails, derivations, traversals-as-data — and reduction is then destruction.

*[Derived (per-segment marking; optimization license)]* Real addresses are heterogeneous chains mixing all three (a scheme-hop, then globs, then containment steps), so the cause is a property of the **segment**, not the address. The payoff of marking it: **the sequence-cause is exactly what a resolution engine may optimize** — subset-sequences reorder and fuse (they are conjunctions; this is what query planners exploit), compositional sequences fold when endpoint-only, resolver-sequences are pipeline barriers.

## Epistemic Status

The trichotomy is structural recognition at discussion-grade, honestly below its `derived` expected type until the exhaustiveness question is treated: three causes are *demonstrated*, but "exactly three" is not argued anywhere — a fourth cause would revise, not break, the per-segment-marking law. The optimization license is derived from the trichotomy where it holds. External grounding candidates exist per the formalisms survey (provenance semirings formalize cause 3's reducibility criterion as a homomorphism — Part III's [[claim-route-as-semiring]]).

Terms defined here: [[term/sequence-cause]].

## Working Notes

- Provenance thin at split time, repaired here: this material descends from steward thought O13/O13a (DISCUSSION-THOUGHTS.udon, 2026-07-29 — the path decomposition + the match-vs-walk dimension) via the 2026-08-06/07 refinement sessions; the source document carried it without cite.
- Open: exhaustiveness (see Epistemic Status). Candidate probe: sweep the ra-feature-matrix rows and the 182-notation survey for sequences that resist all three causes. Candidate fourth cause to adjudicate against the act anatomy when it drafts: mid-address perspective-shift segments (`repo @ commit`, mount/chroot hops) — possibly origin-composition rather than a sequence-cause (2026-08-07 session).
- Live cause-3 specimen from shipped code (rowan `versioning.rb`, INFLUX rowan-archema harvest): `upcast_path` folds per-version transform blocks in order — compositional, foldable precisely because the consumer wants only the endpoint. Version chains are addresses through time whose segments are transforms.
- The act-anatomy slot design (Part II [[form-act-anatomy]]) consumes this claim's per-segment marking; if the trichotomy is revised, the `seq⊇/seq→/seq∘` notation follows.
