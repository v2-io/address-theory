<!-- GENERATED VIEW — do not edit by hand; regenerate with `bin/compose-lexicon`

Every term group in def/, whole, in outline (dependency) order: each group's
leading prose, then its |term entries and blocks as they stand in the file.
def/*.ud are the definitions; this file is a rendering of them, not a second
source. Udon comments (; …) are shown in italics, starting with `;`. Term links follow
the LEXICON-overview.md conventions (bin/lib/def_terms.rb). What the assembler
noticed about the sources while reading is listed at the end.
-->

# LEXICON

**Contents** — 29 terms in 7 groups

- **Reference** — referents · reference · intended-cardinality · resolve · dereference
- **Binding** — name · mint · maintainer · dangle · collide · binding
- **Match** — match · designator · description
- **Scope** — scope · edge · containment · root-scope
- **Location** — location
- **Resolution** — origin · resolution · resolution-path · walk-step · mediated-step · admissibility · preference · ambiguity
- **Generator** — generator · evaluate

## Reference

*[[def-reference.ud]] · status: proposed · terms: reference · referents · intended-cardinality · resolve · dereference*

A '**[[def-reference.ud|REFERENCE]]**' is recorded material that is used as a proxy or to stand in for its '**[[def-reference.ud|REFERENTS]]**', often when the ==*referents*== are not at hand or can't be known yet. The two terms are only well-defined in relation to each other. A ==*reference*== has an *intent* when it is created— and we specifically define the recorded '**[[def-reference.ud|INTENDED-CARDINALITY]]**' of a ==*reference*==: Whether it intends to stand in for a single ==*referent*== {1,1}, at most one{0,1}, or, for example, as many as there might be {0,N}. To '**[[def-reference.ud|RESOLVE]]**' a ==*reference*== is to determine what it reaches — always *as of a moment*; to '**[[def-reference.ud|DEREFERENCE]]**' it is to ==*resolve*== and take hold of the ==*referents*== as they then stand.

### referents

The things that a reference is proxy for.

### reference

The recorded material used as a proxy for an intended-cardinality of referents.

**Avoid:** address — _; An address is a reference, but it is given its own narrower definition later_

**Relations**

- **dual** ==*referent*==
- **referents** ==*referent*== {0,N}
- **property** ==*intended-cardinality*== {1,1}

**Invariants**

- It is an artifact: it may persist, travel, or be copied; the mind or machine that writes it and the one that uses it may be far apart in time, place, and kind.
- It is written once but may be used multiple times, at different times
- It does not require its referents to be present, or even to exist yet, to be validly written. This allows deferral.
- Determination is deferred and the world may change in the meantime; that gap is constitutive, not incidental.

### intended-cardinality

The range of the number of referents a reference stands in for, with a minimum and a maximum {min,max}.

**Invariants**

- It belongs to the reference (declared at writing), *not* to whatever later processes it.
- It is what gives a miss its meaning, e.g.:
  - Zero  against {1,1} = the writer's model of the world is currently wrong;
  - Three against {1,1} = the reference narrowed insufficiently;
  - Zero  against {0,N} = simply the current answer

### resolve

To determine what a reference reaches — as of now. There is no untimed resolving: an "untimed" answer is either a fiction or an unstated claim that the world has held still.

### dereference

To resolve a reference *and take hold of* its referents. What is obtained is referent-state as of that moment, never the referent timelessly.

### Discussion

— The purpose of a reference can be any number of things (referent-absence, convenience, compactness, machine-readability, stable indirection, etc.)
- The reference is one of two species of *deferred* recorded material — material whose determination happens at use, not at writing (this entry's own invariant language: "this allows deferral"; "determination is deferred"). The sibling species is the *[[def-generator.ud|generator]]*, which *produces* material rather than standing for any — it operates on ==*referents*== without being a proxy for them. "Proxy" belongs to this entry alone: it is the reference's definiens, never the genus name.
- How the relation is made effective — how material actually reaches things — is exactly the next distinction (*[[def-binding.ud|binding]]*, *[[def-match.ud|match]]*); this entry only establishes that the relation exists, is directional, and is carried by an artifact.
- Philosophy-of-language note: strictly (Strawson), agents refer using expressions — referring is an act (in this case a "referral act"). The artifact-first cut is chosen because the theory's machinery manipulates artifacts (documents carry references; stores resolve them); the definition absorbs the act's theory-tractable part (the creator's intent, as expected cardinality) into the artifact, and the events are named with plain verbs — a reference is written, then resolved or dereferenced.

### Examples

- Mailing address: an envelope's address block is a reference; the intended cardinality is one recipient (usually); the days between writing and delivery are the gap.
- Links (such as wikilinks, hyperlinks, anchors, URLs, and URIs)
- Import statements in code
- "The Joseph in accounting"
- Bibliography citation key

### Working notes

- Expected-cardinality settled early on convergence: SQL's scalar subquery (a {1,1} with only a hard error channel), hybrid logic's nominals ({1,1} in the semantics), wikilink stem lookup, steward O15.
- Deliberately left open: the operational-vs-epistemic double bound; @{TARGET-SET} vs referent seating; the internal composite structure of references (real references are usually conjunctions of parts — the address's several lines; treated when paths are); a reference's ORIGIN — resolution is origin-relative, the reference itself is not (see *[[def-resolution.ud|resolution]]*).
- Genus note (2026-08-27): "deferred" as the shared genus of reference and *[[def-generator.ud|generator]]* was adopted from this entry's own invariant wording rather than coined; whether the genus earns its own def entry is open (currently it lives in the two species' prose — see def-generator's working notes).

## Binding

*[[def-binding.ud]] · status: proposed · terms: binding · name · mint · maintainer · dangle · collide*

A '**[[def-binding.ud|BINDING]]**' is the first of the two mechanisms by which a *[[def-reference.ud|reference]]* actually reaches its *[[def-reference.ud|referents]]* (the other is *[[def-match.ud|match]]*): someone (the '**[[def-binding.ud|MAINTAINER]]**') deliberately associates ('**[[def-binding.ud|MINTS]]**') a '**[[def-binding.ud|NAME]]**' with a *[[def-reference.ud|referent]]* and keeps that association (==*binding*==) alive. Everything about a ==*binding*== is a fact about that upkeep, not the ==*name*== or the *[[def-reference.ud|referent]]*. The maintenance involved fails when the ==*binding*== no longer reaches a *[[def-reference.ud|referent]]*, called a '**[[def-binding.ud|DANGLE]]**', or when the ==*maintainer*== has more than one ==*mint*== of the same ==*name*== (they '**[[def-binding.ud|COLLIDE]]**').

The ==*name*== can be considered a new {1,1} *[[def-reference.ud|reference]]* to a *[[def-reference.ud|referent]]* that is more direct. The uniqueness of ==*names*== is a *norm* a ==*maintainer*== may police (cheapest at mint time) in order to avoid collision failures, instead of an invariant.

### name

A repeatable token (e.g., a word, string, or number) that is recognizable wherever it is used.

### mint

The creation of a binding, at a moment, by its first maintainer.

### maintainer

Whoever minted a binding or inherits its upkeep (e.g., a system, person, family, filesystem, registry, community, ...).

### dangle

The failure where a binding no longer reaches a referent — its upkeep has lapsed, or its referent has ceased (or moved) without the binding being updated.

### collide

The failure where one maintainer holds more than one mint of the same name.

### binding

A deliberate, maintained association from a name to a referent.

**Synonyms:** declaration — _; the scope-graphs literature's word_

**Relations**

- **binds** ==*name*== {1,1}
- **to** *[[def-reference.ud|referent]]* {1,1}
- **kept-by** ==*maintainer*== {1,1}

**Invariants**

- The binding is the whole connection; no property of the referent participates, and none of the name's beyond recognizability
- Its only failure modes in this definition are the maintenance failures: ==*dangle*== and ==*collide*==

### Discussion

- Collision is never defined away and must be accounted for. Real systems have collisions and are judged by how they surface them.
- "Joseph" in a large jurisdiction is a binding whose maintaining community is too large for the job; hence the rest of the address.
- Where bindings live (the jurisdiction within which collisions are counted) stays informal until *[[def-scope.ud|scope]]*.

### Examples

|             Name            |          Maintainer            |
|-----------------------------|--------------------------------|
| Filename                    | The OS/filesystem              |
| Phone-book entry            | The publisher                  |
| Variable declaration        | The language scope it lives in |
| "Joseph" within a household | The family                     |
| A DNS record                | The zone's operator            |

### Working notes

- Hardest known stress case: Java packages "exist by virtue of use" — the namespace is constituted by the union of its users, which strains "kept by whoever minted it."
- WRT collision: The scope-graphs calculus agrees — duplicate declarations stay representable precisely so that erroneous states (the normal case in tooling) remain describable. This is a deliberate divergence from a prior formulation that built "unique within parent" into the definitions.

## Match

*[[def-match.ud]] · status: proposed · terms: match · designator · description*

A '**[[def-match.ud|MATCH]]**' is the second mechanism by which a *[[def-reference.ud|reference]]* reaches its *[[def-reference.ud|referents]]*: instead of consulting a maintained *[[def-binding.ud|binding]]*, a test is run at the moment of use. With *[[def-binding.ud|binding]]* it forms the two connection mechanisms, and the classic vocabulary — '**[[def-match.ud|DESIGNATOR]]**' and '**[[def-match.ud|DESCRIPTION]]**' — derives from which mechanism a *[[def-reference.ud|reference]]*'s connection actually uses, never from how it is spelled.

### match

A connection from a reference to referents established by running a test at the moment of use: the referents are whatever, in the world's current population, passes the criteria the reference supplies.

**Avoid:** search, query — _; each names an activity or artifact, not the connection established_

**Invariants**

- Nothing is minted and nothing is maintained; the answer may differ whenever the population differs
- Fails through the world's motion: the same criteria, run later, quietly pick out something else — detectable only if the reference carries something to check against

### designator

A reference (or component of one) that reaches its referent through a *[[def-binding.ud|binding]]* on its name.

### description

A reference (or component of one) that reaches its referents by match.

### Discussion

- Designator/description follows the connection, never the spelling: one written form is a designator where maintainers police the binding, and a description over a population nobody polices. Kind follows maintenance.
- The two mechanisms' complementary failure modes — a binding fails through its maintenance, a match through the world's motion — drive all the later machinery.
- A binding's name, viewed as a reference (per *[[def-binding.ud|binding]]*'s intro), is the degenerate designator; a match whose test is "bytes equal exactly this content" (a hash) is match at its most designator-like — the two mechanisms meet at the corners without merging.

### Examples

|          Example           |          The test              |
|----------------------------|--------------------------------|
| A glob                     | Name-pattern over what's present |
| "The resident aged 47"     | Property over occupants        |
| A WHERE clause             | Predicate over rows            |
| A content hash             | Bytes equal                    |
| A full-text search         | Contains the phrase            |

### Working notes

- Exhaustiveness — every addressing form examined decomposes into bindings consulted and matches run (positional index = match on the current ordering; hash = match on content; forwarding pointer = a binding at the old endpoint) — is held provisionally with its refutation stated: a mechanism that is neither reorganizes this layer.
- Open: whether "population" (what a match tests against) needs its own definition or is carried by *[[def-scope.ud|scope]]* once resolution is in hand.

## Scope

*[[def-scope.ud]] · status: proposed · terms: scope · edge · containment · root-scope*

A '**[[def-scope.ud|SCOPE]]**' makes *[[def-binding.ud|binding]]*'s informal "jurisdiction" precise: it is the unit within which *[[def-binding.ud|bindings]]* are kept and collisions counted. ==*Scopes*== connect to one another by labeled '**[[def-scope.ud|EDGES]]**'; the universal edge label is '**[[def-scope.ud|CONTAINMENT]]**' — pointing from a ==*scope*== to the ==*scope*== enclosing it — and a ==*scope*== with no outward containment edge is a '**[[def-scope.ud|ROOT-SCOPE]]**'. This arrangement is the economics the whole theory rides on: a *[[def-binding.ud|binding]]* need only be unambiguous *locally*, within its ==*scope*==, and locally-cheap *[[def-binding.ud|bindings]]* compose across ==*edges*== into global reach. No *[[def-binding.ud|maintainer]]* ever needs a globally unique *[[def-binding.ud|name]]*.

### scope

The unit of resolution locality: the jurisdiction within which a maintainer's bindings are kept and collisions counted.

**Synonyms:** jurisdiction, namespace

**Avoid:** context, region — _; both too loose to carry the locality claim_

**Relations**

- **holds** *[[def-binding.ud|binding]]* {0,N}
- **enclosed-by** ==*scope*== {0,1} — _; via a containment edge; absent exactly for a root-scope_
- **edges** ==*edge*== {0,N}

**Invariants**

- Collision is counted within one scope; two mints of one name in different scopes are simply two bindings

### edge

A labeled, directed connection from one scope to another, traversable when resolving.

**Relations**

- **from** ==*scope*== {1,1}
- **to** ==*scope*== {1,1}
- **label** *[[def-binding.ud|name]]* {1,1}

**Invariants**

- Labels beyond containment are an open extension point; what an edge's label means is priced by resolution policy, not fixed here

### containment

The universal edge label: the edge from a scope to the scope enclosing it.

### root-scope

A scope with no containment edge outward.

**Invariants**

- Every scope reaches at least one root-scope through containment

### Discussion

- Every line of the mailing address names a scope; "Joseph" is cheap precisely because its scope is a household, and scope-composition is what makes the cheap name globally reachable.
- Corresponds to the scope-graphs formalism (scopes, labeled edges, scoped data — ref/vanantwerpen-2018-scopes/ Fig. 1), generalized past programs; each inheritance is verified where used, not here.

### Examples

- A household, a directory, a document's tree, a module, a namespace, the DNS root
- Edge labels in the wild: lexical parent, module import, filesystem mount, "extends", a symlink's jump

### Working notes

- Deliberately left open: whether root-scopes deserve the name @{WORLD} and any one-root-per-scope claim; whether edge labels want a taxonomy or stay an open set priced per policy (lean: open set).

## Location

*[[def-location.ud]] · status: proposed · terms: location*

A '**[[def-location.ud|LOCATION]]**' is what you get when a *[[def-scope.ud|scope]]* is itself the *[[def-reference.ud|referent]]* of a *[[def-binding.ud|binding]]* — a named *[[def-scope.ud|scope]]*. Location-ness is a role a *[[def-scope.ud|scope]]* plays when some enclosing jurisdiction keeps a *[[def-binding.ud|name]]* for it, not a new kind of thing.

### location

A scope that is itself the referent of a binding — a named scope.

**Synonyms:** named scope

**Avoid:** place, position, address — _; address is a later, composite notion_

**Relations**

- **scope** *[[def-scope.ud|scope]]* {1,1}
- **named-by** *[[def-binding.ud|binding]]* {1,N} — _; more than one = aliases, all equally real_

**Invariants**

- Nothing is added beyond scope + binding; in particular uniqueness does not re-enter here — an unpoliced parent with two same-named children holds two locations whose shared name surfaces as ambiguity at resolution

### Discussion

- The address's middle lines are locations: the city is a scope (keeps street names) named in the state's scope; the street a scope (keeps house numbers) named in the city's. A chain of locations, each named in the previous one, is the recognizable shape of an address — but @{ADDRESS} as a term is deferred until *[[def-resolution.ud|resolution]]* exists to define it against.
- Exact scope-graphs correspondence: "declaration with associated named scope" — their module, shown equally to be a class, a package, a record: anything named that encapsulates bindings. The same generality is claimed here.

### Examples

- A directory (bound by its name in its parent)
- A city; a mailbox
- A module; a keyed element in a document

### Working notes

- Open: must a location's own scope and the binding's holding scope be related? Registries keep names far from what they name — lean: no.

## Resolution

*[[def-resolution.ud]] · status: proposed · terms: resolution · origin · resolution-path · walk-step · mediated-step · admissibility · preference · ambiguity*

'**[[def-resolution.ud|RESOLUTION]]**' is where everything above comes together: a *[[def-reference.ud|reference]]*, resolved from an '**[[def-resolution.ud|ORIGIN]]**' *[[def-scope.ud|scope]]*, is worked back to the *[[def-reference.ud|referents]]* it reaches as of that moment. Each result carries its '**[[def-resolution.ud|RESOLUTION-PATH]]**' — the route that justifies it, made of '**[[def-resolution.ud|WALK-STEPS]]**' (traversals of standing *[[def-scope.ud|edges]]*) and '**[[def-resolution.ud|MEDIATED-STEPS]]**' (*[[def-scope.ud|edges]]* that exist only through a sub-==*resolution*==). The answer is shaped by declared policy — '**[[def-resolution.ud|ADMISSIBILITY]]**' (which path shapes count at all) and '**[[def-resolution.ud|PREFERENCE]]**' (which admissible results win) — and every outcome has standing, including none and too-many ('**[[def-resolution.ud|AMBIGUITY]]**').

### origin

The *[[def-scope.ud|scope]]* a reference is used from.

**Invariants**

- Constitutive, not optional: the same reference yields different referents from different origins, legitimately

### resolution

The outcome of resolving a reference: the set of referents it reaches, from an origin, as of a moment — each carried with its resolution-path.

**Synonyms:** lookup

**Avoid:** fetch — _; resolution determines referents as of the moment; taking hold of them is *[[def-reference.ud|dereference]]*'s further step_

**Relations**

- **of** *[[def-reference.ud|reference]]* {1,1}
- **from** ==*origin*== {1,1}
- **as-of** @{moment} {1,1} — _; always — untimed answers are fictions or unstated stability claims_
- **results** *[[def-reference.ud|referent]]* {0,N} — _; each carried with its resolution-path_
- **under** (==*admissibility*== | ==*preference*==) {0,N}

**Invariants**

- Zero, one, and many are all outcomes; the reference's intended cardinality gives each its meaning

### resolution-path

The sequence of edge traversals and connection events (bindings consulted, matches run) that justifies one resolution result.

**Relations**

- **steps** (==*walk-step*== | ==*mediated-step*==) {1,N}

**Invariants**

- The path is the evidence; reducing a result to its bare referent discards exactly the justification — a choice, never a default

### walk-step

A path step that traverses a standing *[[def-scope.ud|edge]]*; no resolution is needed to take it.

### mediated-step

A path step whose edge exists only through a sub-resolution: a name must first be resolved to obtain the edge — an import, a symlink, a forwarding address, a delegation.

**Invariants**

- A mediated step's sub-resolution may not use the step it enables

### admissibility

The declared half of a resolution policy that says which path shapes count at all — a constraint over edge-label sequences.

### preference

The declared half of a resolution policy that orders admissible results — shadowing ("nearer beats farther", "local beats imported") made inspectable.

**Invariants**

- A selection under declared preference is disclosed by construction; a selection without one is a silent guess

### ambiguity

More than one maximally-preferred result.

**Invariants**

- An outcome, not an error — it is what insufficient narrowing is — and it surfaces with its candidate set

### Discussion

- The path-carrying form and the admissibility/preference split are the scope-graphs line's current formulation, verified at the primaries (ref/vanantwerpen-2018-scopes/ §2.1; ref/zwaan-2024-defining/ §3); per-reference policy is their own endpoint, and result-level preference is where their retrospective says the theory should go (ref/zwaan-2023-scope/ §5). Formal inheritance holds under premises established where used: resolution against a snapshot; finiteness; acyclic paths; regular admissibility; preference a preorder applied as a minimum.
- Admissibility + preference are not exhaustive of policy: accessibility (may this asker, via this route, reach this thing) is a known third component, deliberately left open.
- Why the moment is in the definition while the inherited literature keeps it in the machinery (steward diagnosis, 2026-08-10): the scope-graphs line is static-first — a fixed program, with change arriving late as scheduling and incrementality bolt-ons — which is an unprincipled foundation even for codebases in practice, and is plausibly why their Rust case went stuck. This theory is TST-side: continuously changing corpora from the first axiom, so as-of is constitutive and @{moment} is load-bearing (not yet defined — see working notes).
- The mediated-step discipline is kept by argument, not inheritance: the modern scope-graphs line erased explicit mediation, its solvers deadlock on self-influencing mediation (an everyday pathology in our domain — symlink loops, circular forwarding), and its own retrospective concedes the erasure weakened the model. Termination under open edge labels is this theory's undischarged obligation.

### Examples

- The refused package, end to end: "several people by that name" is ambiguity surfaced with candidates; the missing digit is a reference narrowing short of its {1,1}; the forwarding card at the old apartment is a mediated step
- "Local shadows imported" as a declared preference; "no walking onward from inside an imported context" as admissibility

### Working notes

- Deliberately left open: the stability-aware outcome (an answer given while the world can still change it is not yet an answer; the growing-world half has a portable theorem — ref/rouvoet-2020-knowing/ §5.1–5.2); stability under retraction and rebinding (nearest work: Zwaan 2022, unread); the cycle election; accessibility's factoring; @{moment} as its own term (the as-of index every resolution carries); @{ADDRESS}/@{DIRECTIONS} over the step kinds; selection policies below preference.
- This group defines eight terms; split when any earns independent weight (candidate seams: the step kinds; the policy pair).

## Generator

*[[def-generator.ud]] · status: proposed · terms: generator · evaluate*

A '**[[def-generator.ud|GENERATOR]]**' is the second species of *deferred* recorded material — the first is the *[[def-reference.ud|reference]]*, and the genus (determination at use, not at writing; the gap constitutive) is named in def-reference's own invariants. Where a *[[def-reference.ud|reference]]* stands as proxy for *[[def-reference.ud|referents]]* that exist or may yet, a ==*generator*== *produces* material that does not exist until the generator is used. To '**[[def-generator.ud|EVALUATE]]**' a ==*generator*== is to perform that production — always from an origin, as of a moment, exactly as *[[def-resolution.ud|resolution]]* is origin-relative and moment-indexed — most often after dereferencing the *[[def-reference.ud|references]]* it consumes as inputs. A ==*generator*== is not a *[[def-reference.ud|reference]]*: it operates *on* *[[def-reference.ud|referents]]* without standing for any.

### generator

Deferred recorded material that produces material rather than standing for it.

**Avoid:** directive, template, macro — _; each names a surface construct or artifact family hosting generators, not the kind itself_

**Relations**

- **inputs** *[[def-reference.ud|reference]]* {0,N} — _; usually — the steward's formulation below_
- **produces** material {0,N} — _; "material" is not yet a lexicon term: things, facts, text — or further deferred items_

**Invariants**

- It is an artifact exactly as a reference is: written once, usable many times, at different times, from different origins; the writing-to-use gap is the same constitutive gap
- Its output may itself contain deferred material — references, or further generators; producing is not fully determining
- No referents stand behind it, so the miss vocabulary (count-against-intended-cardinality) does not apply to it; what failure means for an evaluation is its own question, currently open

### evaluate

To perform a generator's production, from an origin, as of a moment — the produce-side counterpart of *[[def-reference.ud|resolve]]*.

**Invariants**

- There is no untimed evaluating, for the same reason there is no untimed resolving

### Discussion

- Steward's seed formulation (2026-08-27, ratifying): "Directives are deferred generators of the atomic parts, often using resolved referents as their primary prerequisite." The "often" does the same honest work it does in def-reference's intro: inputs are typical, not definitional (a generator of constant material is still a generator).
- The duality with *[[def-reference.ud|reference]]*: pull vs produce. A reference's determination consults the world; a generator's transforms into it. The species meet at a corner the way *[[def-binding.ud|binding]]* and *[[def-match.ud|match]]* do: a generator with no inputs producing fixed material is generator at its most reference-like (its output could have been written), without the species merging — what distinguishes them is which failure modes apply, not how much work the use performs.
- The shared genus is what makes a single *hold* stance possible across both species: a reference kept as a value instead of reached through, and a generator kept as material instead of run (a template held for later — including a generator whose output contains generators, which is templating a template), are one operation on the genus, not two device-families.
- Classic vocabulary lands the same way designator/description do in *[[def-match.ud|match]]*: template, directive, macro, view name the *hosting surfaces* generators appear in; the kind follows what the use does, never the spelling.

### Examples

|            Example             |           Produces                       |
|--------------------------------|------------------------------------------|
| A template                     | a document, from bindings + slots        |
| A loop over a collection       | one item of material per referent        |
| A conditional inclusion        | material, or none, per a tested referent |
| A macro / alias expansion      | material in place of its name            |
| A database view definition     | rows, at query time                      |
| A build rule                   | an artifact, from named inputs           |

### Working notes

- Open: does the genus (deferred recorded material) earn its own def entry, or continue living in the two species' prose? Lean: prose until a third species survives — the current candidate (interpretation-under-a-named-vocabulary, as with typed literals) may instead reduce to a reference into a vocabulary's *[[def-scope.ud|scope]]*.
- Open: evaluation policy — does it factor the way resolution's does (admissibility/preference), or is it wholly host-defined? Nothing here presumes either.
- Open: output seating — where produced material lands (the use's own position? a declared destination?) is unowned; the produce-side analog of def-reference's open referent-seating question.
- Open: failure vocabulary for evaluation (the invariant above rules out inheriting the miss vocabulary; nothing replaces it yet).
- Provenance: the 2026-08-27 lexical-forms-redux session (udon repo, `v2/theory/to-integrate/lexical-forms-redux.md`) — the material/deferred carve, the proxy reconciliation (proxy stays reference's definiens; the genus named from def-reference's invariant wording), and the steward's seed formulation quoted above.

## Assembler notes

*What `bin/compose-lexicon` noticed about the sources while reading them. These are about def/, not part of it; the text above is rendered as written either way.*

- `@{TARGET-SET}` names no term defined in def/; left as written — def-reference.ud:45
- `@{WORLD}` names no term defined in def/; left as written — def-scope.ud:35
- `@{ADDRESS}` names no term defined in def/; left as written — def-location.ud:15; def-resolution.ud:51
- `@{moment}` names no term defined in def/; left as written — def-resolution.ud:15, 45, 51
- `@{DIRECTIONS}` names no term defined in def/; left as written — def-resolution.ud:51
- `@{referent}` is not a term id; linked to `referents` by its singular/plural form, 10 uses — def-reference.ud:4, 10, 11; def-binding.ud:4, 5, 15; def-location.ud:4; def-resolution.ud:16
- `@{names}` is not a term id; linked to `name` by its singular/plural form, 1 use — def-binding.ud:5
- `@{bindings}` is not a term id; linked to `binding` by its singular/plural form, 2 uses — def-scope.ud:4
- `@{edges}` is not a term id; linked to `edge` by its singular/plural form, 3 uses — def-scope.ud:4; def-resolution.ud:4
- `@{scopes}` is not a term id; linked to `scope` by its singular/plural form, 1 use — def-scope.ud:4
- `@{references}` is not a term id; linked to `reference` by its singular/plural form, 1 use — def-generator.ud:4
- 1 `|term` id written with spaces inside the brackets; read as `resolve` — def-reference.ud:27
- 5 `|term` ids written with spaces inside the brackets; read as `name`, `mint`, `dangle`, `collide`, `binding` — def-binding.ud:7, 8, 10, 11, 12
- 2 `|term` ids written with spaces inside the brackets; read as `match`, `designator` — def-match.ud:6, 11
- 1 `|term` id written with spaces inside the brackets; read as `evaluate` — def-generator.ud:15
- `def-reference.ud:32` a `|discussion` line begins "—" where its other lines begin "- "; it renders as a paragraph, not a list item
