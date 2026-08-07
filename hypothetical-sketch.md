# Hypothetical sketch — the reference act, made concrete

*For us. Everything here is wet clay — spellings are IR-grade placeholders, names are stand-ins, and any piece may be dissolved by the theory as it develops. The point is to hold the whole hypothetical in one place so we can push on it. (Origin: Joseph's notebook notes + the 2026-08-06 evening exchange.)*

## 1. The typed reference-act value: `@<…>`

A reference act as a first-class **typed value**:

```udon
|element
  :a-path @<descriptor/descriptor/descriptor>
```

`@<…>` says: *this value is a reference act* — a path / query / designator-bundle — whether or not anything resolves it here.

Why this container and not another:

- **Free real estate, verifiably.** The `@` guard admits only `[`, `.`, identifier-start. `<` fails it, so `@<` is plain text in every existing document — extending the guard is additive; nothing retypes.
- **Inherits the envelope's measured virtues**: depth-counted close, clean in all six value contexts, the one ratified multi-line form, self-delimiting (the Line Scan continues after it).
- **Inherited cost**: an unbalanced `>` in the interior closes early — spell comparison operators without `>` inside, or nest.
- Spelling question, now with a lean (post-§8's literal dissolution): `@<X>` ≅ `<ref:X>` — the reference-act is an ordinary envelope-family **type**, with `@<…>` as its grep-friendly sugar. The act is a typed literal like any other; everything special about it lives in the engines that resolve it, not in the value model.

**It may never need to be user-facing at all** — an IR that sugar desugars into, with elegant surface spellings arriving later, demand-driven (set-theoretic / join / SQL-ish dialects welcome as *spellings over the same IR*). If a surface spelling turns out elegant enough, the IR simply is the spelling. Both outcomes fine; neither decided.

## 2. The desugar — today's `@` becomes sugar over the IR

```udon
@element[designator]      ; ≡  !resolve-and-insert @<|element[designator]/{1,1}>
@element.heading          ; ≡  !resolve-and-insert @<|element.heading/{0,*}>
```

*(directive name up for grabs)*

What this buys, and why it feels right:

- **The frozen three-field selector never grows — it gets reinterpreted** as the sugar tier over the general language. Wholesale replacement (what the freeze was waiting for), and ref ⊂ path *by construction* rather than by discipline.
- **Same idiom as identity sugar**: `[key]`/`.trait` desugar to designated attributes; `@…` desugars to a directive + typed value. Sugar always lowers to the general mechanism.
- **Resolution lives in the dynamics tier**: recognition carries the act; engines execute it. "The core never resolves" stays exactly true.

*Flag (open):* today's `@` is an inert selector with a consumer menu (transclude | merge-attributes | leave-inert, default inert). `!resolve-and-insert` bakes in one disposition. Candidate refinement: desugar to `!resolve` (or `!ref`) with **disposition as a parameter** the engine defaults — one mechanism, citation-`@` and transclusion-`@` as two dispositions, menu preserved.

## 3. Step grammar: udon-within-a-step, `/` between steps

- **Within a step**: udon's own spelling, exactly as written in a document — `|element[key].trait` is one step meaning element AND key AND trait. Mirror-the-document; nothing new to learn.
- **Between steps**: `/` is the **walk** — descend/narrow into the previous step's result.

```udon
@<|section[intro]/|h4/{1,*}>     ; into section[intro], then its h4s, one-or-more
```

Open within this: does `/` mean strictly *child*, or *within* (any depth)? Is `||` (any-depth) a step prefix, a different walk operator, or the default? (The measured agent behavior — relational-first, `||type[key]` at any depth — suggests any-depth wants to be cheap.)

## 4. Arity — the expectation, typed

The suffix characters carry their designed Kleene readings, now at a fifth site (element sugar, schema cardinality, type-algebra exponents, path arity — and here, resolution expectation):

| Spelling | Bound | Miss means |
|---|---|---|
| bare `@[uuid]` | {1,1} | loud failure — your model is wrong |
| `@[uuid]?` | {0,1} | an answer: absent |
| `@*.header` | {0,*} | an answer: empty set |
| `@h4+` | {1,*} | loud only at zero |
| `{n,m}` in the IR | anything | the general form the suffixes sugar to |

- `!` stays reserved (schema-side it means *required*; whether it has a reference-side job — e.g. "must already exist / never create" — is open, not assigned).
- **The double bound has a seat here**: operational vs epistemic — `{1,*}{1,3}` = "I'll take one-or-more, but I *expect* no more than three or I've misunderstood the data" — divergence triggering dialogue rather than binary failure, and the accumulated divergences are free calibration data.
- On references, suffixes were "deliberately absent pending replacement." Under the desugar they are not tuple growth — they're sugar over `{n,m}` in the IR.

## 5. Multiple designators — conjunction, verification, and renames for free

```udon
|element[surrogate-key][#slug][uuid]
```

- **Co-referring designators, conjoined.** Each independently narrows; jointly they *over-determine* — which is the mis-fetch defense from the problem statement's Fetch Assumption: if resolution-by-slug and resolution-by-uuid disagree, that's a loud contradiction instead of a silent wrong delivery.
- **Kind marked in-band** (`[#slug]` — sigil spelling open): the resolver reads the designator's kind instead of inferring it by precedence. (relata infers doi/sha/bibkey/path/fuzzy by classification order; this declares it.)
- **Redundant routes**: resolve by whichever designator the resolving community knows.
- **Renames become stacking.** Adding a new designator while keeping the old *is* the expand-contract window for names — the alias table moved in-band, using stacking the language already has. (Lifecycle/retirement of old designators: open, and it is the LINEAGE question wearing concrete clothes.)
- This is the multi-key open question (`[9][scribal]`) subsumed: multiple keys are just multiple designators; uniqueness questions become questions about which conjunctions the store enforces.

## 6. `$DOCUMENT` — the document as a designated pseudo-element

```udon
|'$DOCUMENT'[unique-file-path][content-hash] :mtime … :permissions …
```

Every document implicitly is (or can be addressed as) an element whose designators are its path and its content hash, carrying file attributes as ordinary attributes. Consequences — this may be the single highest-leverage piece:

- **The to/into seam dissolves formally.** One tree; `$DOCUMENT` nodes mark substrate boundaries; "filesystem-layout-aware" vs "logical-only-ignore-document-boundaries" become **two traversal policies over the same tree** (route through `$DOCUMENT` designators, or skip those nodes) — two engines, one address language.
- **The entity/value-object pair, instantiated on the document itself**: `[unique-file-path]` designates the entity-slot; `[content-hash]` pins the current value object. As-of, staleness detection, and fetch-verification get their footing from these two designators alone.
- **Root attributes get their owner.** The "no phantom owner" rationale behind warn-on-root-`:key` is answered: `$DOCUMENT` is the owner. Frontmatter dissolves into `$DOCUMENT`'s attributes; a snippet is *the interior of a `$DOCUMENT`*.
- **(Joseph, 2026-08-07) It also answers the partial/whole/store trichotomy**: "what's the difference between a udon doc meant to be a partial vs a whole record vs a store of records?" — nothing in the grammar; it *just depends on what you decide to do with the root element*. One pseudo-root, three dispositions — the distinction becomes a declaration about `$DOCUMENT` (its designators, its schema binding) rather than three document kinds. Same move for the spec's open top-level-attribute question.
- **The BASENAME union gets a substrate**: one logical store over many physical manifestations = a description over `$DOCUMENT` designators (stem-match across the manifestation ladder), resolved by the store's engine.
- Consistent with the designated-`$` family: designated, not reserved, quoted-off in longhand, sugar-friendly.

## 7. Engines, handlers, perspectives

Resolution is performed by an **engine** relative to a **perspective** — and different engines legitimately give the same reference act different answers:

- a **logical engine** (skips `$DOCUMENT` boundaries; the corpus as one bowl),
- a **filesystem-aware engine** (routes through them),
- an **as-of engine** (resolves against a moment — the commit-pinned view),
- a **store engine** (resolves within a declared store's population and its layout ladder).

The engine inherits the resolution-ladder obligations (typed outcomes, candidates on plurality, requested-name preserved, never silent best-guess). Which engines exist, and how a context binds one, is LUSS territory (§9).

## 8. The dynamics-tier check — can `@<…>` results be the *only* objects directives act on?

*(Joseph's check to cash, 2026-08-06 late: the foreach's only operands would be act-results — `!{let a | @<…>}` … `!{foreach a as el} Hello !{{el:name}}! …{end-foreach}` — directive spellings provisional.)*

What falls out if it holds — each a real unification:

- **The template accessor language stops being a second addressing dialect.** Every template language reinvents a dot-path accessor (`item.address.city`) — an undeclared second way of addressing. Here `!{{el:name}}` *is* the inner-selection projection (`:attribute` on a bound referent) — one addressing language, used by the templates because there is nothing else to use.
- **The ctx object dissolves into perspectives.** The pipeline sketch's "ctx object + code" stops being an ad-hoc data bag: a binding (`el` in the foreach) creates a *local perspective*, and `el:name` is an act resolved relative to it. External context (config, host state) becomes acts against LUSS-declared stores bound at that pipeline stage — which is exactly the "context-objects at that level of the pipeline" note, now principled.
- **Arity types the directives.** `foreach` takes {0,\*}; a scalar interpolation takes {1,1} — so interpolating a plural act is a *typed failure* (the classic silently-join-a-list template bug becomes a loud ValuePlural), and existence-`!if` takes {0,1}. Directive signatures are arity-bounded act types; template type-checking falls out of the bounds we already have.
- **`!include` stops being special** — it is a directive whose operand is an act (plus an ascription). The whole dynamics tier reduces to: *control flow + acts as operands + projections on bindings + filters as value-object transforms after resolution*.
- **The pipeline question localizes.** "Desegmentation before or after (or both) liquid rendering" becomes per-*binding*: a `let` resolves at its stage, against that stage's engine — the decision is made where the act is bound, not globally.
- **And the algebra connection deepens** (§10): `foreach` is enumeration of an intensional set's extension — iteration, query, and schema-check are the same τ, consumed three ways.

**The literal dissolution (Joseph, same night — this closed what were two open bits):** there is no operand bifurcation. Every directive operand is a **typed literal**; `@<…>` is one more envelope-family type, exactly as `<2026-07-11>` is a temporal literal — and "some directives expect their literal to be a literal reference-act, which they resolve when the time is right." Consequences, each free:

- **Laziness by construction** — an act-value is inert data until a consuming directive resolves it (as an envelope is lexical until a dialect claims it). `let` binds the literal act; *the consumer picks the resolution moment*; freezing a result is the explicit move (a resolve-now filter), not a semantic fork to legislate.
- **Keep-everything inherited** — no engine loaded ⇒ the act rides as its full lexical form with a warning, nothing lost, retypes identically when an engine arrives (the no-dialects interim, verbatim).
- **Model-conservatism** — the value model already holds `Envelope` and `Reference` as value kinds; the IR adds no ontology, just the reading `@<X>` ≅ `<ref:X>` with grep-friendly sugar.

One open bit remains: **who parses `@<…>` inside directive bodies** — heads are carried unparsed (dialect territory), so the dialect's parser must know the envelope's depth-counting, or the core learns to mark envelope extents inside heads. The nested-envelope-routing question knocking at a new door — same shape, noted, not closed.

## 9. LUSS — the Logical Udon Store Spec (name pending)

*Recorded from Joseph's pipeline notes; the primary consumer of this whole syntax.*

The LUSS is the thing that **puts a store together**: its fluxes (in/out), its layouts (physical manifestation ladder), and its **pipeline** — possibly multiple liquid passes, markdown-unification passes, etc. It references **schemas which define dialects** (element vocabularies / composition components) **and types**, and may use context-objects for liquid parsing at its own pipeline level. Lineage: the rowan/archema store objects (composite stores, roles × modes × adapters) *with more legs* — and it resolves a lot of compiler ambiguity, because the pipeline declares what each stage means rather than leaving it to inference.

Standing hypotheses attached to it (Joseph's, pre-validation):

- **NORMS reduces to it** — the organically-expanding BASENAME conventions become LUSS declarations (manifestation ladder = layout legs; INFLUX = a flux leg).
- **Verisectorium can ride it** — an instance's store triplet (canon+influx, lexicon, SOP) as three LUSS-declared stores.
- The under-specified schema/dialect boundary partially dissolves *into* it: "Ah, udon's TODO dialect" colloquially = the element vocabulary a LUSS's schema declares — no separate dialect machinery needed at this altitude. (How this relates to the envelope-dialect layer — `<temporal:…>` — is open; they may be the same mechanism at two grains or genuinely two things.)

**The LUSS as a decider of resolution moments** (Joseph, same night, flagged as a thought that may be mixing implementation in): the hand-drawn pipeline had some acts dereferenced *early* — e.g. intra-document, an element already named in this very document, resolved cheaply for redundancy's sake — and others dereferenced *late*, after markdown/consolidation passes, when the whole store is available to resolve against. The principled residue, if it holds: the resolution moment has (at least) two legitimate deciders — the consuming directive (§8) and the LUSS stage — with the **perspective varying by stage** (document-local early, whole-store late). Because acts are inert literals until resolved, multi-stage resolution is *monotone*: each stage resolves what its perspective reaches, the remainder rides through. Note the symmetry: progressive resolution across pipeline stages is progressive routing (problem statement, Path §) on the pipeline's time axis — each stage an intermediate owning "what can be resolved from here." The hostile question that travels with it: **is multi-stage resolution confluent?** Early-resolving an act and *then* running a transforming pass (markdown unification, liquid) could yield a different document than transforming first and resolving late — if so, stage order is semantics, not plumbing, and the LUSS declaring it is not optional. (Which may be exactly why the notebook's "before or after (or both)" question felt like a pipeline decision that *must* be made.)

**The open question that matters most** (Joseph, 2026-08-06): how well does the reference-act syntax serve *schemas* — can it use, or be, the algebraic types / set theory?

## 10. The type-algebra connection (sketched answer to §9's question — promising, unverified)

The type-algebra spike established: schemas, views, queries, and censuses are **one boolean-closed algebra of intensional sets** — an element type τ = (name-set, row constraint, content constraint), with `{n,m}` arities, decidable subtyping on the shorthand fragment.

The correspondence, if it holds:

- **A step is a τ.** `|element[key].trait` is literally (name = element, row ⊇ {$key = key, $traits ∋ trait}) — a step *is* an intensional set, spelled in udon.
- **A designator is the singleton-forcing constraint**; a description is the general case — the designator/description split is "does this τ provably have ≤ 1 inhabitant in this population."
- **`/` (walk) is composition through the content/containment dimension** — which the algebra already models (its content constraints are hedge languages over child types). A reference act = a chain of τ-selections composed through containment.
- **Arity bounds are the algebra's own exponents** — the same {n,m} in both places is not a coincidence; it is one axis at its fifth and sixth sites.
- **Set operations come free.** The algebra is closed under ∪, ∩, difference — so union/intersection/difference *of reference acts* are well-defined the day we want spellings for them (the SQL-ish and set-theoretic surface dialects land here), and **census and migration fall out**: inhabitants of τ_old \ τ_new is a reference act. The schema's judge, the query, and the migration burn-down would be one object wearing three verbs.
- **The two-bound expectation is a subtyping check**: observed-count ∈ {n,m}_epistemic is a membership test the algebra can state.

If this correspondence survives scrutiny, then the answer to "can the reference-act syntax use the algebraic types" is stronger than *use*: **the reference-act IR is a surface syntax for the algebra's sets, and a schema is a named, ratified reference act with a closure declaration.** That would be the deep unity. It has had one evening of enthusiasm and zero adversarial passes — the natural first hostile question: the algebra's decidability fences (Parikh-only interleave, whole-row order election) — do walk-composed reference acts stay inside them?

## 11. Deliberately uncemented

The directive name(s) · the `#`-kind sigil inside brackets · `@<…>` vs `<ref:…>` · `/` child-vs-within and the any-depth spelling · `!`'s reference-side meaning · designator-retirement lifecycle · the `$DOCUMENT` spelling and which attributes it standardly carries · the LUSS name and its full leg inventory · every surface dialect. All of it stays soft until the theory (and the LUSS design) pulls it firm.

---

## 12. Morning refinements (2026-08-07, Joseph's read-through + responses)

*Appended rather than woven in, so the sections above stay stable while under review. Each item names what it refines.*

### 12.1 Resolve-when: retain-and-emit is the default (refines §2, §8)

The AST always carries the act; the serializer always emits the act back (round-trip honesty by construction, never the resolution). *Whoever calls resolve* owns liveness policy — live/re-resolve (with cache/memoize), resolve-once, materialize — at app level (pre-LUSS) or LUSS level. Live-vs-once-vs-materialized is caller policy over one value kind, never value semantics. ("Skip-once" considered and dropped — that case is just transclusion wanted.) Materialized-vs-virtual views (§12.3) are this same axis.

### 12.2 The act interior has huge lexical space — and it settles the `*`/`?` three-way fight (refines §3, §4)

No prose/same-line ambiguity exists inside the act, so the interior can be glob-native:

```udon
@<{mystuff/h?/**/p}>          ; any |p at any depth within any |h1 |h2 |h3 …
@<{mystuff/h:'$?' true/**/p}> ; literal flag-match: |h? elements (desugared spelling)
```

The three competing readings of `*`/`?` on selectors each get a **positional seat** and stop competing: name-glob (in step names), flag-match (desugared attribute spelling — mirror-the-document where it's literal), cardinality (the arity slot). Matcher kinds are an open set — lexical, structural, **semantic** (a semantic matcher/designator is on the table) — all descriptions, differing in what computes satisfaction.

### 12.3 The select clause — comprehensions, and acts as a rewrite engine (new; answers "what part of the result?")

From/where/join were covered; projection wasn't. Candidate unifier: a **strong list comprehension** (Erlang/Elixir grade — generators, filters, pattern binds, output template), where the output template *is* the select. Consequences:

- Composed acts ≈ a complete udon rewrite engine — SQL views for the corpus, materialized vs virtual per §12.1. (This is family-(D) AST-search-and-transform arriving in principled form: capture + template.)
- **Guardrails from day one**: the power envelope (a rewrite engine is where the digestible guest could become rebol — bounded comprehension, no arbitrary computation) and the algebra's decidability fences as the formal edge.
- **Theory-lab move (Joseph)**: do the initial theoretical work *in* SQL + the type algebra — model a corpus as a schema, write candidate acts as queries; expressibility questions become runnable. Foreign tables ≈ engines/perspectives over document/logical/physical.
- This is also the justification for the name: an act that can produce (rewrite, project, materialize) is more than a reference — hence reference-*act*.
- Open: is projection a *slot* of the act (comprehension reading) or a separate act *composed after* (algebra reading)? Possibly the same claim in two dresses.

### 12.4 Composition (new; must-not-preclude, and mostly free)

CTE/`with` falls out of three existing mechanisms meeting: **binding** (`!{let a | @<{…}>}`), **origin-accepts-bindings** (`@<{a/further…}>` — the origin slot referencing a bound act/result), and **nesting** (acts are typed literals; envelope-family values nest). The algebra's boolean closure supplies combinators (∪/∩/difference of acts) whenever spellings are wanted. Simple designator concatenation is the degenerate case.

### 12.5 The `@<{ … }>` spelling and the `@{…}` inline pair (refines §1, §2)

- `@<{ … }>` with `}>` as closer **removes the one measured envelope cost**: unbalanced `>` (comparison predicates — `age > 30`) is now free inside. Nesting is generally more reliable.
- The elegant pair: `@{element[39902]}` **inline form in prose** = direct interpolation / realized transclusion-and-insertion; `@<{…}>` = the typed scalar, carried. The disposition split (§2's flag) gets its spelling: braces = insert-here, angle-braces = carry-as-value.
- Both are additive: `@{` and `@<` currently fail the `@` guard (plain text everywhere) — and CORE's inline-brace principle *already names* "the anticipated `@{…}`" as the fourth brace form. Reserved ground on both sides.

### 12.6 The act's anatomy — and PATH-imperative vs DEST-declarative (refines §3; possibly the deepest cut)

The bigger question under all spelling vacillation (globs vs comprehensions vs SQL — those are *surface dialects over the slots*):

```text
@<{ [origin: implicit | explicit | universal | a binding]
    [route components — ORDER MATTERS]
    [destination components — order does NOT matter]
    [designator components & arity — legal vs expected]
    [projection / unpacking / rewriting?] }>
```

The load-bearing distinction, however the slots collapse: **PATH is imperative** — piecewise, incremental, each hop resolved progressively (*how to get there*); **DEST is declarative** — an unordered conjunction the engine satisfies however it can (*what is true there*). Walk-vs-match generalized into the act's anatomy; the two great addressing paradigms (trail-following vs set-description) given seats in one act instead of competing languages. Even if route/dest/designator components collapse syntactically, the theory must keep this distinction very, very particular.

**Refined (2026-08-07, Joseph): sequence has three causes, and imperative/declarative is derived from the cause, not a slot primitive.** "Pathwise" = sequential, from any of: **subset-sequence** (containment chain — a nested conjunction wearing a path costume; declarative in nature, imperative-executable; *the* general reason path/dest conflate everywhere), **resolver-sequence** (each step's output feeds a different resolver — truly imperative, a pipeline barrier), **compositional sequence** (offsets/transforms — reducible by folding iff endpoint-only and associative; *irreducible when the path is the product*, e.g. drawing the line, provenance trails). Real acts are heterogeneous chains, so the cause is marked **per segment**. Engine payoff: the cause is exactly the optimization license — subset-segments reorder/fuse, compositional segments fold, resolver-segments barrier. Full statement in the problem statement's "Why sequence appears at all."
