# Formalisms survey — existing CS that illuminates the reference-act model

*2026-08-07, written by a fresh-eyes agent asked to connect theory-and-lexicon.md + hypothetical-sketch.md (+ ra-feature-matrix.md) to established results, avoiding the prior survey's family W (term-rewriting positions, lenses/optics, RPQs, conditional XPath, separation logic, Saltzer, Plan 9, Dexter, Lorel/UnQL, content addressing, de Bruijn, HoTT paths).*

**Register conventions, used throughout:**
- **[recall]** — training recall; verify before citing externally.
- **[verified]** — checked against a fetched primary/secondary source this session.
- **INSTANTIATES** — I claim the theorem's premises actually hold for our objects, and I give the mapping.
- **RHYMES** — structural resemblance worth mining, but the premises do not (or not yet) instantiate; I say where the gap is.

Ordered roughly by how much I think each one gives us, not by field. §1 and §2 are the ones I'd read first; §10 is the incidental-findings section about our own model.

---

## 1. Scope graphs — a ready-made theory of "reference acts resolved relative to perspectives"

**[verified]** Néron, Tolmach, Visser, Wachsmuth, ["A Theory of Name Resolution"](https://web.cecs.pdx.edu/~apt/esop15.pdf), ESOP 2015 (LNCS 9032, pp. 205–231); extended TR TUD-SERG-2015-001; a decade of follow-on work surveyed in ["Scope Graphs: The Story so Far"](https://drops.dagstuhl.de/entities/document/10.4230/OASIcs.EVCS.2023.32) (EVCS 2023). Project page: [pl.ewi.tudelft.nl/research/projects/scope-graphs](https://pl.ewi.tudelft.nl/research/projects/scope-graphs/).

This is the closest thing I found to a *pre-existing formalization of our exact central object*, and it was not in family W.

**Their setup:** a language-independent **scope graph**: nodes are *scopes*; scopes contain *declarations* and *references*; labeled edges connect scopes (lexical parent, module import, etc.). Name resolution is defined as a **resolution calculus**: a reference resolves to a declaration iff there is a well-formed *resolution path* through the graph, where well-formedness is a **regular expression over edge labels**, and among competing paths a **visibility ordering on labels** (e.g. local shadows imported shadows outer) picks winners. Resolution is thus literally *path-finding under a regular constraint plus a preference order* — declarative, with a derived deterministic algorithm. Later work (Statix, van Antwerpen et al. [recall: OOPSLA 2018 "Scopes as Types"]) makes scopes first-class data usable for type checking, and handles the hard circularity (resolution needed to build the graph that resolution runs over) via a sound scheduling discipline.

**The mapping (INSTANTIATES, with one adaptation):**

| Ours | Theirs |
|---|---|
| REFERENCE ACT | reference node |
| DESIGNATOR binding held by a naming community | declaration in a scope (the scope *is* the naming community, made formal) |
| LOCATION as containment coordinate | scope with a labeled parent edge |
| PATH / progressive routing ("each intermediate owns its next hop") | resolution path; each edge traversal is one hop, governed by that scope's outgoing edges |
| ENGINE + PERSPECTIVE (logical vs filesystem-aware vs store) | the well-formedness regular expression + visibility ordering — **different engines = different path-label policies over the same graph**, which is *exactly* our §6 "two traversal policies over one tree" claim about `$DOCUMENT`, already proven workable at language scale |
| `pol:skip-doc` (row 22) | admit-or-forbid a `$DOCUMENT` edge label in the path well-formedness regex |
| Ambiguity / found-many | multiple minimal resolution paths; the calculus surfaces the candidate set — their treatment of ambiguous imports maps onto our typed found-many outcome |

**The adaptation needed:** scope graphs resolve *names* (designators); our acts also carry *descriptions* (predicates). But Statix-lineage work already generalizes queries to "find all declarations matching P reachable under regex R" [recall], which is precisely descriptor-conjunction over a reachability policy. I'd say the burden of proof has flipped: the interesting question is not "can scope graphs model us" but "what does our model have that scope graphs don't" — my answer: arity/epistemic bounds, canonicity classes, fetch-verification pins, and the sequence-cause taxonomy. That's a publishable-delta-shaped list, and it also means everything scope graphs *proved* (soundness of the resolution algorithm w.r.t. the calculus; the alpha-equivalence/renaming theory — their Prop. on capture-free renaming is the formal footing for row 28's rename lineage) is inheritable rather than re-derivable.

**What it gives us that we hadn't thought of:** the **visibility/shadowing order as a first-class engine parameter**. We have "never a silent best-guess," but real resolution constantly *does* prefer (local over global, first over later) — scope graphs show how to make preference *declarative and inspectable* (an ordering on edge labels) instead of procedural, so "auto only when unique" can relax to "auto when unique-after-declared-preference" without violating the no-silent-guess law. That's the principled seat for row 14's `sel:first(doc-order)`.

---

## 2. Hygienic macro expansion & sets-of-scopes — the confluence question has a name, and the field's answer

**[recall — high confidence; verify the exact POPL year before external citation]** Matthew Flatt, "Binding as Sets of Scopes," POPL 2016; prior lineage Kohlbecker et al. 1986 ("Hygienic Macro Expansion"), Dybvig syntax-case, Flatt "Composable and Compilable Macros" ICFP 2002.

Our §9 hostile question — *early-resolving an act then running a transforming pass could yield a different document than transforming first and resolving late* — is, almost word for word, the **hygiene problem**: macro expansion is a transforming pass; identifiers (reference acts) ride through it; naive expansion resolves them against the wrong context (capture). Forty years of Scheme/Racket engineering is the record of the field trying every position on our question:

- **Resolve-early (fully expand references before transforming):** fails — transforms introduce new bindings and new references that must interleave with resolution.
- **Resolve-late positionally (resolve after all transforms, by where the identifier sits):** fails — this is *silent re-satisfaction inside the pipeline*: the transform moved the text into a context where the same words pick out something else. Our §9 worry, confirmed as a real, canonical failure, not a hypothetical.
- **The stable answer (sets of scopes):** neither. Each identifier *accumulates scope metadata as it travels* — it carries, in-band, enough of the perspective it was written under that late resolution is faithful to authorial intent regardless of what transforms happened in between. Resolution = "declaration with the largest scope-set subset match."

**Mapping quality: RHYMES, strongly — the premises don't instantiate directly** (macro expansion is a specific transform class; our passes are arbitrary), but the *design theorem* transfers: **confluence of resolve-order is not provable in general and is not achieved by picking a stage order; it is achieved by making the act carry its perspective.** For us: an act resolved early should not be replaced by its result *bare* — it should be replaced by (result + the perspective it was resolved under), so a later pass, or a later reader, can detect that the transform invalidated the resolution context. Note §12.1 (retain-and-emit: AST always carries the act) is already 80% of this move — the missing 20% is carrying the *perspective/moment of any materialized resolution* alongside, which is also exactly our own fetch-verification pin pointed inward at the pipeline. I'd promote that from observation to design principle: **materializations carry their perspective, or they are lies waiting to age.**

---

## 3. Kahn process networks — Joseph's hunch, adjudicated: half applies, and the halves matter

**[recall — Kahn 1974, "The Semantics of a Simple Language for Parallel Programming," IFIP Congress; determinacy via least fixed points of Scott-continuous functions on stream domains. High-confidence classical result.]**

**Kahn's theorem, stated honestly:** a network of deterministic processes communicating only over unbounded FIFO channels, each process a *continuous* (hence monotone) function from input-stream histories to output-stream histories, computes a unique result — the least fixed point — **independent of scheduling/execution order**. Non-blocking reads or tests-for-emptiness break the premise and the theorem.

**Where it INSTANTIATES:** *within* a fixed LUSS pipeline, if each stage is a deterministic function of what has arrived (documents/acts in, documents/acts out), then interleaving, batching, parallelism, and incremental streaming of the stages **cannot change the result**. That's a real gift: it licenses the implementation to stream/parallelize/incrementalize the pipeline aggressively with zero semantic risk — *provided* stages never do the KPN sins: peeking ("is the store empty *yet*?" — resolving against a partially-populated perspective is exactly a non-blocking read), or nondeterministic merge. Corollary worth keeping: **a stage that resolves a description against a still-filling store violates Kahn's premise** — the {0,N} answer "empty set" is only Kahn-safe when the perspective is a *completed* input. This gives formal teeth to "the epistemic difference between zero-as-answer and zero-as-not-yet": in pipeline terms it's the difference between a blocking and a non-blocking read.

**Where it does NOT apply (the confluence question):** Kahn gives *scheduling*-independence for a **fixed network**. Resolve-then-transform vs transform-then-resolve are **two different networks** — Kahn is silent on whether they agree. So the hunch's target ("monotone processes → scheduling-independent") is correct but aimed at the other half of the problem. The confluence half belongs to §2 above (carry the perspective) and §4 below (commutation of rewrite relations). Saying this plainly because it was asked for: **KPN will not prove multi-stage resolution confluent; it proves the orthogonal, still-valuable property that a *declared* stage order can be executed any way you like.** Which strengthens, rather than weakens, §9's conclusion: *the LUSS declaring stage order is not optional* — Kahn then makes everything below that declaration free.

---

## 4. Commutation of rewrite systems — the right tool for what confluence remains

**[recall — classical: Newman's Lemma; Hindley–Rosen Lemma; critical-pair analysis (Knuth–Bendix); all in Terese, *Term Rewriting Systems*, 2003.]**

Family W had term-rewriting *positions*; it didn't have the commutation results, which are the ones our §9 needs. Model resolution as one rewrite relation →R (act ⇒ result) and each transforming pass as another →T. The question "does stage order matter" is precisely **commutation**: does →R∘→T ⊆ →T∘→R (up to joinability)?

- **Hindley–Rosen Lemma [recall]:** if →R and →T are each confluent and they commute pairwise, their union is confluent. So the global question decomposes into *per-pass commutation lemmas* — exactly the granularity the LUSS has (a pass inventory).
- **Critical pairs:** the finite (per pass) set of overlap patterns where R and T touch the same material. For us the overlaps are enumerable and already half-known: (a) a transform rewrites text *inside* an unresolved act's lexical form (T edits the question); (b) a transform changes what a description matches (T edits the answer — §2's capture); (c) resolution inserts material that the transform would have transformed (R outruns T — the transclusion-then-markdown-unify case). That's a checklist with teeth: **a pass is order-independent w.r.t. resolution iff its critical pairs with (a)(b)(c) are joinable**, and each non-joinable pair is a place the LUSS *must* declare order. Markdown-unification almost certainly fails (c); a pure whitespace normalizer passes all three.
- **The realistic outcome the field would predict:** you will not get global confluence; you will get a **commutation matrix over the pass inventory**, and that matrix *is* the semantic content of a LUSS stage ordering. I'd put the matrix itself on the roadmap — it's small, decidable-by-inspection per pass pair, and turns "stage order is semantics, not plumbing" from a worry into an artifact.

**Adjacent, worth one line each [recall]:** *Partial evaluation* (Jones–Gomard–Sestoft 1993): "resolve early" is specialization; **binding-time analysis** — annotating each expression static (early) or dynamic (late) subject to a *congruence* condition — is a worked-out discipline for exactly the LUSS's "who decides the resolution moment," including the known result that good binding-time division is a global, not local, property. And *strategic rewriting* (Stratego/ELAN [recall]) is the precedent for §12.3's rules-vs-strategies split: the comprehension supplies rules; the LUSS supplies strategy; keeping them separate is what kept those systems analyzable.

---

## 5. Monad comprehensions & nested relational calculus — §12.3's guardrails are theorems already

**[recall — high confidence: Wadler "Comprehending Monads" (Math. Struct. Comp. Sci. 1992); Buneman, Naqvi, Tannen, Wong, "Principles of Programming with Complex Objects and Collection Types" (TCS 1995); Wong's conservativity theorem (JCSS 1996); Cheney–Lindley–Wadler "A Practical Theory of Language-Integrated Query" (ICFP 2013).]**

The §12.3 candidate unifier (Erlang-grade comprehension: generators, filters, binds, output template) is the **nested relational calculus (NRC)** presented as a monad comprehension. What the literature already settled:

- **The "slot vs composed-after" open question (row 19, blocked) is answered — they are provably the same claim.** The comprehension desugaring theorem: every comprehension normalizes to compositions of map/filter/join primitives (and back). "Projection as a slot of the act" and "projection as an act composed after" are the two normal forms of one object. I'd unblock row 19 on this basis: pick the comprehension *surface* and the composed *IR*, and the desugaring theorem is the license that nothing was decided by the pick. (INSTANTIATES, provided the act algebra stays within collection-monad operations — which the "bounded comprehension, no arbitrary computation" guardrail is precisely promising.)
- **Conservativity (Wong) [recall]:** NRC queries from flat inputs to flat outputs express exactly flat relational algebra — intermediate nesting adds no expressive power. For us: letting comprehensions build nested intermediate shapes (natural for udon trees) does not smuggle in power beyond the algebra; the decidability fences aren't threatened by nesting *per se*. This directly de-risks the §10 correspondence.
- **Normalization/avalanche results (Cooper; Cheney et al.; the Links line) [recall]:** comprehensions over a database normalize to a bounded number of flat queries — the formal backbone for the SQL theory-lab move (§12.3): if candidate acts are NRC-expressible, translation to the SQL lab is not an analogy but a normalization procedure.
- **The known cliff:** the moment the output template can call arbitrary functions, or generators can range over function results, you're out of NRC and every guarantee above dies at once — the rebol boundary is exactly the NRC boundary, and it's sharp, not a gradient. The guardrail can therefore be *stated* rather than gestured: comprehension bodies range over collection-monad ops + a fixed scalar-function signature, full stop.

---

## 6. Provenance semirings — "the path is the product" is a change of semiring

**[recall — high confidence: Green, Karvounarakis, Tannen, "Provenance Semirings," PODS 2007; aggregation extension Amsterdamer–Deutch–Tannen PODS 2011; difference/monus: Geerts & Poggi, and Amsterdamer et al. — the difference case is genuinely unsettled in the literature.]**

Joseph's hunch, adjudicated: **this one survives contact, with a precise mapping and one warning.**

**The theorem:** for *positive* relational algebra (select/project/join/union) over K-relations (tuples annotated with elements of a commutative semiring K), query evaluation commutes with semiring homomorphisms. Consequences: evaluate once over the most general semiring — polynomials ℕ[X], "how-provenance" — and every coarser answer (boolean: does it exist; counting; why-provenance; lineage; trust/security) is obtained by a homomorphism *after the fact*.

**The mapping (INSTANTIATES for the positive fragment):** a resolution engine evaluating an act over the boolean semiring returns the *destination* (referents exist/don't); the same engine over ℕ[X] returns the *routes* — which designators, which containment hops, which joins produced each referent, as a polynomial whose monomials are exactly the derivation paths. So:

- `product:dest` vs `product:path` (row 9c, §12.6) is **not a per-segment flag the theory must carry — it is the choice of semiring at evaluation time**, and the reducibility criterion ("foldable iff endpoint-only") *is* the homomorphism theorem: folding is applying the homomorphism ℕ[X] → 𝔹 (or → endpoint-monoid). "Reduction is destruction" gets its formal statement: homomorphisms lose exactly the kernel, and you can say which one.
- Compositional sequences: keeping the route = working in the free structure (free monoid of hops / free category of morphisms); folding = the unique homomorphism out of it — the "iff associative" clause is literally the monoid law that makes the fold well-defined. Our criterion is correct and is a special case.
- **The warning that cuts against us:** the semiring theorem covers the **positive** algebra. Our §10 algebra is boolean-closed *including difference* — and provenance for difference is the known murky spot (m-semirings/monus exist but the clean commutes-with-homomorphism story weakens [recall]). Concretely: **the census/migration act τ_old \ τ_new (row 21) is exactly the act whose provenance the field cannot yet give cleanly.** If we ever want "show me *why* this record is in the migration burn-down" (we will), that's a real open edge, worth knowing before promising route-products uniformly across the act algebra.

---

## 7. Hybrid logic — designator vs description is nominal vs proposition, with a decidability cliff on the map

**[recall — Areces & ten Cate, "Hybrid Logics" chapter, *Handbook of Modal Logic* 2007; Blackburn's nominal-tense lineage from Prior. Complexity results are classical but verify before external citation.]**

Modal/hybrid logic evaluated over trees is the established semantics of XPath-like languages (family W touched conditional XPath); what family W didn't surface is that **hybrid logic already formalized our designator/description split, as its founding move**:

- A **nominal** is an atomic formula true at *exactly one* world — a designator, with {1,1} built into its semantics rather than checked. An ordinary **proposition** is true wherever it's true — a description, {0,N} by nature.
- The **@ᵢ operator** ("truth at the world named i") is origin-shifting: `@ᵢφ` = "resolve φ from perspective i" — our `orig:` slot as a logical connective. (The sigil coincidence is free of content but pleasing.)
- **What transfers:** basic hybrid logic H(@) stays decidable (satisfiability PSPACE-complete over arbitrary frames [recall]) — designators + perspective-shift are cheap. **The cliff:** adding the ↓ binder ("name the *current* world and use it later") makes satisfiability **undecidable** over arbitrary frames [recall]. Translated to us: an act that can *bind the node it is currently visiting and demand equality with it elsewhere in the same act* — "an element whose later sibling references *this very node*" — is the ↓ pattern, and it is the same wall XPath-with-full-variables hits. Our matrix's working-notes candidate **"cross-act constraint: these two acts must resolve to the same referent"** is standing directly in front of this cliff: as an *engine-level check between two acts* it's harmless; as a *composable operator inside the act language* it's plausibly the single feature that would break the §10 decidability fences. Recommendation with teeth: keep referent-equality as an act-*pair* obligation (like `verify:co-refer`, row 4), never as an in-act binder.

---

## 8. Robust anchoring — over-determination + prose-spans were built and measured in 2000

**[verified]** Phelps & Wilensky, ["Robust Intra-document Locations"](http://wwwconference.org/www9/w9cdrom/312/312.html) (WWW9 / Computer Networks, 2000) and the companion robust-hyperlinks work (["Robust Hyperlinks: Cheap, Everywhere, Now"](https://link.springer.com/chapter/10.1007/978-3-540-39916-2_3); D-Lib 2000). Living descendant: [Hypothesis's fuzzy anchoring](https://web.hypothes.is/robust-anchoring/) and the W3C Web Annotation Data Model's selector stack.

Row 25 (prose-span addressing) and the over-determination doctrine have a direct engineering ancestor: Phelps–Wilensky locations attach **multiple independent descriptors** to a span (position, surrounding context, content signature) with an explicit **re-attachment algorithm** that tries them in order and *reports its confidence* — a URL plus ~five carefully chosen signature words suffices to re-find a document, and small signatures re-find spans even after edits. W3C Web Annotation standardized the same shape (TextQuoteSelector = exact + prefix + suffix — a conjunction of descriptors — alongside TextPositionSelector), and Hypothesis runs it at scale with a documented fallback ladder.

Mapping: INSTANTIATES trivially (it's the same design, discovered by the same argument — descriptor disagreement as signal, not noise). Value: (a) row 25 need not be invented — adopt the selector-stack shape and the measured lesson that *re-anchoring confidence must be surfaced, not swallowed* (their version of no-silent-best-guess, learned empirically); (b) the fallback *ladder with confidence report* is a fifth engine obligation candidate: when resolution succeeded via a weaker descriptor than the strongest one carried, say so — that's a "found-but-degraded" outcome our typed-outcome list doesn't yet have. (Found-one / found-many / found-none / found-but-stale / **found-but-weakly** — the mis-delivery near-misses live there.)

---

## 9. Shorter connections — each one paragraph, each still with a named theorem or a named cliff

- **Regular hedge languages & the XML schema-language taxonomy [recall — Murata, Lee, Mani, Kawaguchi, "Taxonomy of XML Schema Languages using Formal Language Theory," ACM TOIT 2005].** The §10 algebra's content constraints are hedge languages; this paper is the map of exactly which closure/decidability properties survive at which expressiveness rung (local ⊂ single-type ⊂ restrained-competition ⊂ regular): DTDs and XML Schema sit low and lose closure under union; RELAX NG sits at full regular hedge languages, which are closed under boolean ops with decidable inclusion — the closure the §10 algebra wants is available *only* at the top rung, and the rungs below are the documented graveyard of "we restricted for tooling convenience and lost the algebra." A known-corpses finding in the strict sense: the field tried the convenient restrictions; the algebra died each time.
- **Parikh/Presburger fence [recall — Parikh's theorem 1966; Presburger decidability].** "Parikh-only interleave" + {n,m} arities means the countable fragment of the algebra lives in semilinear sets / Presburger arithmetic, where satisfiability of arity-bound conjunctions (can `{1,*}{1,3}` and a sibling constraint co-hold?) is *decidable* — so epistemic-bound checking and even static "this act's bounds are unsatisfiable" linting are inside the fence by construction. Walk-composition must be checked against this (the §10 hostile question stands), but the arity layer itself is safe.
- **Incremental view maintenance & differential dataflow [recall — classical IVM; McSherry et al., "Differential Dataflow," CIDR 2013].** §12.1's live/once/materialized axis is the materialized-view problem verbatim; "silent re-satisfaction" of a cached description is *stale view* and the field's cure is incremental maintenance, not re-resolution. Differential dataflow is the strongest modern result: deterministic incremental computation of (even recursive/fixpoint) collection queries under arbitrary input change — and it is itself a KPN-family determinacy result, so §3's licenses extend to *incrementally maintained* engines. If the corpus gets big and acts get live, this is the implementation theory to reach for first.
- **Consistent query answering [recall — Arenas, Bertossi, Chomicki, PODS 1999].** Epistemic-bound divergence ("several exceed three — proceed?") is an integrity violation with *repair semantics*: CQA defines answers true in every minimal repair vs some repair — a principled menu for what an engine may return *while* the dialogue is pending, rather than blocking or guessing. RHYMES→INSTANTIATES if we ever want engines to keep answering under acknowledged divergence; complexity is the caution (CQA jumps to coNP-hard fast for some constraint classes).
- **PEGs — Joseph's hunch, adjudicated: mostly shallow, one transferable lesson.** PEG's defining move is **ordered choice**: alternatives are tried in order, first match wins, and as a consequence PEG alternation is *not commutative* and language-theoretic reasoning (is L(a/b) = L(b/a)?) becomes undecidable-in-general [recall — Ford POPL 2004]. That is precisely the pathology of *inferred* designator-kind precedence (relata's classification order) — and §5's in-band kind marking (`[#slug]`) is exactly the move from PEG ordered-choice to commutative declared alternation. So: cite PEGs as the cautionary precedent for *why* kind is declared, not as machinery to adopt. The grammar-shaped feeling of the act language is real but is better served by the hedge-automata/RPQ line already on the table.
- **Free categories / paths-as-morphisms [recall — standard].** One tightening of §6's semiring story: routes compose; the route-space of a corpus is the free category on its containment/edge graph; engines that fold are functors out of it. Cheap to state, and it makes "the referent is the route" a typed statement (the act's result lives in hom-sets, not object-sets) rather than a flag.

---

## 10. Incidental findings about the model itself (invited, so given plainly)

1. **The typed-outcome list is missing "found-but-weakly"** (§8 above) — resolution that succeeded only via a fallback descriptor is currently indistinguishable from a clean hit, which quietly re-creates the silent near-miss the over-determination doctrine exists to kill.
2. **Materializations don't yet carry their perspective** (§2). Retain-and-emit keeps the *act*; nothing in §12.1 keeps the *perspective + moment of a resolution* beside its result. Without it, every early-resolve inside a transforming pipeline is un-auditable, and the confluence question can't even be *detected* at runtime, let alone repaired.
3. **The cross-act same-referent constraint is the decidability landmine** (§7). Keep it between acts, out of the act language.
4. **"Monotone" in §9 is doing two jobs and only one is safe.** Stage-wise resolution is monotone in *acts resolved* (the set shrinks) but not in *truth of resolutions* (a later transform can invalidate an earlier one). The Kahn-ish comfort the word imports belongs only to the first reading; the second is exactly the non-confluence. Suggest splitting the word.
5. **Zero-as-answer needs a completed perspective** (§3). A {0,N} "empty set" resolved against a store a pipeline is still filling is a non-blocking read — formally the thing that voids determinacy. The engine obligations may want a fifth entry: *an engine answers zero only from a perspective it can attest is complete* (or returns found-none-so-far as a distinct outcome).
6. **Difference is the provenance hole** (§6): route-products can't currently be promised for acts using `comb:diff` without walking into an open research problem. Fine to promise for the positive fragment; say so.

---

## Addendum after reading the 0.9.1 primer (arrived mid-pass; lay-of-the-land, not a gate)

Reading `v2/udon-0.9.1-primer.md` after drafting the above changed nothing structural but sharpened three things:

- **The PEG caution (§9) applies inside the recognition substrate already, at one spot.** Unlabelled envelopes resolve by "declared dialects bid, **first claim wins**" (primer §4.1) — that is ordered choice, with its known consequence: dialect *declaration order* is semantics, and two dialects whose claim-sets overlap make `<2026-07-11>` mean different things under reordering — the same non-commutativity that in-band kind marking (`[#slug]`) was designed to remove for designators. Not a defect (the type-label spelling is the escape hatch, exactly as `[#kind]` is), but the parallel is worth naming in one place: *unlabelled = ordered-choice precedence; labelled = commutative alternation* — one principle, now visible at two sites.
- **`$partial-key` is prior art for "found-but-weakly" (§8, finding 1) from the other direction.** The core already refuses to let a degraded designator masquerade as a clean one (truncated `[` → `$partial-key`, never `$key`; resolution automatically excludes it). The typed-outcome addition I proposed is the same fail-safe philosophy applied at resolution time instead of recognition time — so it's not a new doctrine for the project, just the existing one's missing half.
- **Bounded-lookahead law strengthens the Kahn license (§3).** "A chunk boundary is never end of input" means recognition itself is already a Kahn-safe stream process by language law; the pipeline-determinacy license extends down through recognition, not just across LUSS stages. Conversely, primer §4.3's "the error channel is a teaching channel" is one more consumer of §3's completed-perspective point: a zero-answer or anomaly emitted from a still-filling perspective teaches the wrong lesson.

## What I'd verify next, if any of this becomes load-bearing prose

All **[recall]** items above before external citation — in particular: exact statement/venue of Wong's conservativity theorem; the hybrid-logic ↓ undecidability frame conditions (it's frame-class-sensitive); Flatt's POPL year; the monus/difference provenance state of the art (it may have moved since my training). The two **[verified]** anchors (scope graphs, Phelps–Wilensky) are safe to cite now.

Sources fetched this session: [Néron et al., ESOP 2015 PDF](https://web.cecs.pdx.edu/~apt/esop15.pdf) · [Scope Graphs project page](https://pl.ewi.tudelft.nl/research/projects/scope-graphs/) · [Scope Graphs: The Story so Far (EVCS 2023)](https://drops.dagstuhl.de/entities/document/10.4230/OASIcs.EVCS.2023.32) · [Phelps & Wilensky, Robust Intra-document Locations (WWW9)](http://wwwconference.org/www9/w9cdrom/312/312.html) · [Robust Hyperlinks (Springer)](https://link.springer.com/chapter/10.1007/978-3-540-39916-2_3) · [Hypothesis robust anchoring](https://web.hypothes.is/robust-anchoring/)
