# Proposed fixes to `def/` — for the steward's line-by-line review

*From Claude (Opus 5.5), 2026-10-09, following `inf/SOLIDIFICATION-PASS-2026-10-09.md` §3 and `inf/ai-risk-model-feedback-2026-10-08.md`. Nothing here has been applied. Each item gives where, the current text verbatim, the proposed text, and the reason. Accept, change or drop each one separately; I'll apply exactly what you keep. Items marked **(waits on the theory step)** depend on the result-and-moment question in `inf/RESULT-AND-MOMENT-2026-10-09.md`.*

## A. Mechanical (from the ai-risk-model feedback)

### A1. `referents` → `referent` as the term id

`def-reference.ud` defines the term as `referents`, but ten references across four files write `@{referent}`, including the `|rels` rows `:dual @{referent}` and `:referents @{referent} {0,N}`.

Now:

```
|term-group[reference][referents][intended-cardinality][resolve][dereference]
…
  |term[referents] The things that a reference is proxy for.
```

Proposed:

```
|term-group[reference][referent][intended-cardinality][resolve][dereference]
…
  |term[referent] A thing that a reference is proxy for.
```

The leading prose (`**REFERENT**s`) and the plural `@{referents}` in prose stay as they are, under A2.

```udon
|term[referent] A thing that a reference is proxy for.
  :pos noun
  :pl  -s
```



### A2. State the plural convention

Five references use a plural (`@{bindings}`, `@{edges}`, `@{names}`, `@{references}`, `@{scopes}`). Both renderers already resolve them (`bin/compose-defs` via dry-inflector; ai-risk-model's builder). Proposed: one sentence in ORIENT's def/ bullet, after the format description:

> `@{term}` may be written in the singular or the plural of the term's id (`@{edges}` for `edge`); both name the one term.

### A3. State the deferred-term convention, and mark `moment`

`@{ADDRESS}`, `@{DIRECTIONS}`, `@{TARGET-SET}` and `@{WORLD}` use upper case for terms deliberately not yet defined. That's the convention `defs.source.ud` states in its header ("`@{TERM}` flagged: load-bearing but not yet defined"), but `def/` never says so. `@{moment}` is the exception: lower case, and the target of a `|rels` row. Proposed: one more sentence in ORIENT's def/ bullet,

> `@{UPPER-CASE}` names a term that is load-bearing but deliberately not yet defined; tools report it as deferred, not unresolved.

and, until `moment` is defined, `@{moment}` → `@{MOMENT}` in `def-resolution.ud` (three places: the `:as-of` row, the discussion line about the steward's diagnosis, the working-notes line).

### A4. The em dash

`def-reference.ud`, the first `|discussion` item begins `—` where every other item uses `-`. Markdown renderers show it as a paragraph.

Now: `    — The purpose of a reference can be …`

Proposed: `    - The purpose of a reference can be …`

## B. Definitional

### B1. `ambiguity` relative to intended cardinality

Now (`def-resolution.ud`):

```
  |term[ambiguity] More than one maximally-preferred result.
```

Proposed:

```
  |term[ambiguity] More maximally-preferred results than the reference's intended cardinality allows.
```

Why: as written, every multi-result answer to a {0,N} reference is an ambiguity, which contradicts resolution's own invariant ("Zero, one, and many are all outcomes; the reference's intended cardinality gives each its meaning") and def-reference's miss table ("Three against {1,1} = the reference narrowed insufficiently"). The intro's wording ("including none and too-many (**AMBIGUITY**)") already says "too many", so it stays. ai-risk-model had to coin "several" to say "more than one, as intended".

Proposed working-notes line, so the reason travels with it:

```
    - Ambiguity is "more than intended", not "more than one": in the scope-graphs line every program reference intends exactly one declaration, so the two coincide there, and Statix states the singleton at the use site ("the result of resolution must be a single declaration-type pair", ref/vanantwerpen-2018-scopes/ §3; the `single` constraint, ref/rouvoet-2020-knowing/ §3.2). Intended cardinality is the general form.
```

### B2. `resolve`: "as of now" **(waits on the theory step)**

Now (`def-reference.ud`): `To determine what a reference reaches — as of now. There is no untimed resolving: …` The intro says "always *as of a moment*", and `def-resolution` has `:as-of @{moment}`.

The 2026-08-10 commit that landed these verbs wrote them "in simple form", so "now" may be deliberate. I'm not proposing a change on its own. I think the two wordings are both right and are the split itself: a resolution is always *performed* now, but it may be *as of* another moment (a past state, a pinned version). If you agree, the wording lands with `moment` (see the result-and-moment note). If you meant only the first, "now" stays and the as-of question moves elsewhere.

### B3. A local hit needs a path

`resolution-path`'s prose includes "connection events (bindings consulted, matches run)"; its `|rels` allow only edge steps, at least one. A binding found in the origin scope itself crosses no edge, so it has no path. In all three scope-graph formulations, that case is a path with no edges: ESOP 2015 ends every path in a declaration step `D(x)` and allows the empty prefix; Scopes as Types' rule NR-Refl gives the zero-edge path; Zwaan 2024 returns ⟨path, declaration⟩ with the path stopping at the declaring scope.

Now:

```
  |term[resolution-path] The sequence of edge traversals and connection events (bindings consulted, matches run) that justifies one resolution result.
    |rels :steps (@{walk-step} | @{mediated-step}) {1,N}
```

Proposed, minimal (stands without the theory step):

```
  |term[resolution-path] The edge traversals (possibly none) and the final connection (a binding consulted or a match run) that justify one resolution result.
    |rels :steps   (@{walk-step} | @{mediated-step}) {0,N}
          :ends-in (@{binding} | @{match})           {1,1}
```

If the theory step settles that a result is ⟨path, what the final connection reached⟩, `:ends-in` becomes that pair's second half, and this entry simplifies again.

### B4. Where collisions are counted

`def-binding` counts a collision per maintainer; `def-scope` counts it per scope ("two mints of one name in different scopes are simply two bindings"). SB 53 (one legislature, one name minted in two code chapters) is where they disagree, and ai-risk-model tripped on it. Binding comes before scope in reading order, so the fix is wording, not a link.

Now (intro, `def-binding.ud`): `… or when the @{maintainer} has more than one @{mint} of the same @{name} (they **COLLIDE**).`

Proposed: `… or when the @{maintainer} has more than one @{mint} of the same @{name} in one jurisdiction (they **COLLIDE**).`

Now: `|term[collide   ] The failure where one maintainer holds more than one mint of the same name.`

Proposed: `|term[collide   ] The failure where one maintainer holds more than one mint of the same name in one jurisdiction.`

"Jurisdiction" is already the entry's informal word ("Where bindings live (the jurisdiction within which collisions are counted) stays informal until @{scope}"), and `def-scope` makes it precise.

### B5. `def-scope`: containment and labels

Containment. `:enclosed-by @{scope} {0,1}` says at most one enclosing scope, but the root-scope invariant says every scope reaches "at least one" root, and acyclicity is never stated. ESOP 2015's well-formedness says what's needed: the parent "is a partial function" and "The parent relation is well-founded."

Now: `      - Every scope reaches at least one root-scope through containment`

Proposed: `      - Containment is well-founded: following it from any scope ends, at exactly one root-scope`

(If you want containment to be plural one day, a directory reachable through two parents, say, the fix goes the other way: `:enclosed-by {0,N}` and "at least one" stays. I'd keep it singular until something asks for that.)

Labels. `edge`'s `:label @{name} {1,1}` makes "containment" a *name*, which would need a binding in some scope. In every formulation labels are a small fixed set, a parameter of the resolution policy ("labels l ∈ L a set of edge labels", Scopes as Types Fig. 1).

Now: `          :label @{name}  {1,1}`

Proposed: `          :label label    {1,1}  ; one of a small set the resolution policy's author fixes; not a name bound in a scope`

("label" left as a plain word, the way `def-generator` leaves "material", until it earns an entry.)

## C. Small wording

### C1. `def-location`: "Exact" correspondence

ESOP 2015's module has three conditions: named, encapsulates declarations, and "can be imported into another scope" (§2.4). A location drops the third.

Now: `    - Exact scope-graphs correspondence: "declaration with associated named scope" — their module, shown equally to be a class, a package, a record: anything named that encapsulates bindings. The same generality is claimed here.`

Proposed: `    - Close scope-graphs correspondence: "declaration with associated named scope" — their module, shown equally to be a class, a package, a record: anything named that encapsulates bindings. The same generality is claimed here, without their third condition (a module must also be importable into another scope, ref/esop15/ §2.4); a location need not be.`

### C2. `def-reference`: "referral act"

The term retired on 2026-08-09 was REFERENCE-ACT; "referral" is a different word.

Now: `referring is an act (in this case a "referral act")`

Proposed: `referring is an act (a "referring act")`

## D. Optional additions from the papers

### D1. `def-binding` working note: Java packages

The note calls packages that "exist by virtue of use" the hardest stress case. Rouvoet 2020 §6 decomposes them as `defs.source.ud` guessed. Proposed addition to the note:

```
      The scope-graphs line models this as match plus import edges: "compilation units query for all other compilation units in the same package and make their types accessible by adding import edges" (ref/rouvoet-2020-knowing/ §6) — membership by match, and every binding still kept by its own maintainer.
```

### D2. `def-binding` working note: uniqueness as a query

Proposed addition to the collision note:

```
      The field enforces uniqueness the same way, as a query rather than a definition: Scopes as Types leaves field-name uniqueness to "a scope graph query that requires that a field name reference … resolves to a single declaration" (ref/vanantwerpen-2018-scopes/ §2.3), and Knowing When to Ask writes it as an explicit `noDups` premise (ref/rouvoet-2020-knowing/ §2.2).
```

## After you decide

I'll apply what you keep in one commit per entry, re-run `bin/compose-defs` and the new lexicon assembler, and record it in CHANGELOG. ai-risk-model is pinned to udon `90f4fb6`, so nothing reaches it until its pin moves.
