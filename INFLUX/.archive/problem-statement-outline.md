# The addressing problem — a first-principles statement

**What this is.** The problem of paths and references, derived from the nature of the act rather than assembled from the estate's prior work. The prior work enters at the end, as evidence and constraint against questions the derivation forces — never as premise. Register: everything before §9 is reasoning offered for attack; nothing is decided here.

---

## 0. Why this problem exists at all

Work here is done by many short-lived minds over long-lived artifacts. No mind retains context across its boundary, so **the artifacts are the only shared memory** — and therefore the only medium through which one mind can direct another's attention to a thing. That directing act — *pointing* — is the primitive under every query, edit, include, citation, handoff, and verdict.

Two consequences frame everything below:

- A pointer must work for a reader who shares **no session state** with its writer. Whatever frame the pointer assumes must be reconstructible from artifacts alone.
- The pointed-at world **changes between writing and reading** — that is not an edge case, it is the normal case, because the whole purpose of the estate is to keep improving the artifacts.

So the problem, stated once: **make the act of pointing survive the absence of the pointer and the change of the pointee.**

## 1. Reference is an act between parties in a frame

A name picks nothing out by itself. It picks something out *relative to a context* — "the third one," "the one called `atom`," "`./notes.md`" — and the act succeeds only when writer and reader resolve against the same context. This is not a syntax fact; it is what reference *is*.

Therefore the first design object is not the path string but the **frame**: the set of contexts a pointer may be relative to, and the mechanism by which the reader recovers the writer's context. Every anchor convention (relative, absolute, home, project-root, store-root, host, protocol) is a context in this sense; a context can itself be named, which is what makes registries and mappings possible — and what lets a physical relocation be absorbed by re-binding a context instead of rewriting every pointer.

Questions this forces:

1. What is the finite set of contexts, and is it closed or extensible?
2. Where does a context's binding live — with the document, the store/instance, the call — such that a turnover reader can recover it? (A binding that lives only in a session is, by §0, not a binding.)
3. When a pointer crosses a boundary (agent→agent, machine→machine, prose→tool), what must travel *with* it for its context to survive the crossing?

## 2. Two ways to pick a thing out — and everything they generate

There are exactly two fundamental modes of picking out:

- **Designation** — by *what it is*: a rigid name minted for the thing and bound to it by convention (a slug, a key, a hash-of-content). Designators pick out one thing or fail; their meaning is held by the naming community, not by the world's current state.
- **Description** — by *what is true of it*: a predicate the world satisfies ("every element with trait `canon`," "the file whose stem is `atom`," "the second child"). Descriptions designate whatever currently satisfies them — zero, one, or many — and that is a feature, not a defect.

Everything usually treated as separate design topics falls out of this dichotomy:

- **Arity** is intrinsic to descriptions and degenerate for designators. An address's expected cardinality is therefore part of its *type*, knowable before resolution — and a miss means three different things under expect-one (your model is wrong: loud), expect-maybe (an answer: absent), expect-many (an answer: empty).
- **Rigidity is a spectrum**, because real forms mix the modes: a corpus-minted key is fully rigid; an external identifier is rigid only as far as the external community keeps its promise; a stem-match is a description wearing a name's clothes. The *kind* of a pointer, not its string, determines its rigidity — and a resolver should report the kind even when resolution fails.
- **Walk vs match** is the procedural shadow of the same split: a walk (descend this, then this) follows structure step by rigid step; a match searches a scope for satisfiers. Most real addressing composes both — walk to a scope, match within it, walk within the hit.
- **Position is the weakest description** — "the nth one" is falsified by any insertion — which is why position may serve as *output* (a fact about the current world) but is treacherous as a *stored* pointer. Where positional pointing is genuinely wanted, it should have to say so.

Questions:

4. Is the address model honest about mode — can a reader of any address tell designation from description (and thus its rot class and arity) without resolving it?
5. What is the composition grammar of the two modes — which sequences (walk·match·walk…) are admitted, and does the composite's type (arity, rigidity) compute from its parts?

## 3. The persistence contracts — what "still means it later" can mean

Between writing and use, the thing may move, be renamed, be rewritten, split, merge, or die. A pointer survives change only by having *committed* to what it tracks. There are four commitments available — plausibly exhaustive, since they are "same identity / same description / same bytes / same moment":

| Contract | Tracks | Survives | Betrayed by |
|---|---|---|---|
| **Identity** | the thing itself, via minted name | motion, rewrite, restyling | rename / split / merge — identity-change itself |
| **Description** | whatever now satisfies the predicate | everything, trivially | the answer changing meaning silently |
| **Content** | exact bytes/value, via hash | motion, renaming | any edit — which is the point: it *detects* change |
| **Moment** | the state at time t | everything, by never claiming the present | nothing — but it answers about *then*, not now |

Every robust addressing mechanism is a *combination*: name the place by identity, pin the version by content, scope the claim by moment; let descriptions be queries, not stored links. And each contract's failure needs its own machinery:

- Identity's failure mode — rename/split/merge — is the one that cannot be solved from outside the naming system. It needs **lineage**: aliases that keep old names resolving, records of split/merge, and an owner for the question "is this the same thing as that was?" This is the deepest and least-owned part of the whole territory.
- Description's failure mode — silent re-satisfaction — is why stored descriptions should be rare, marked, and re-verified at use.
- Content's "failure" is its function — staleness *detection* — so the pin's scope (whole file vs addressed part) decides how many false alarms the reader eats.
- Moment-pointers need a time substrate; where history is already kept (version control), as-of comes nearly free at the grain history is kept at, and is expensive at finer grains.

Questions:

6. Which contract combinations does the design bless as idioms, and does each stored pointer *declare* its contract so readers know its rot class?
7. Who owns identity-through-change — the mint, the store, a lineage record — and what does a resolver do when it meets a name that has since split or merged?
8. What is the time story — which grains get as-of, and is a moment a qualifier that composes with any address or a different address kind?

## 4. The universe has strata, and identity lives at one of them

The things pointed at are not flat. Two orthogonal structures matter:

- **Containment**: estate ⊃ project ⊃ store ⊃ document ⊃ element ⊃ attribute/part ⊃ span. Pointers reach small things through big things, so the address model must either treat all strata as one navigable structure or define seams between per-stratum languages — and the seams are where prior systems leak (the tradition that hands the document out-of-band and then cannot name it is the cautionary instance).
- **Realization**: at nearly every stratum there is a *logical* thing and its current *physical serving* — the record vs its file(s), the store vs its directory layout, the collection vs its partitioning. The logical thing is the stable party; the serving is the changeable one *by design*. **Rot is, mechanically, storing a pointer to a serving when the intent was the thing.** The corollary cuts deep: physical layout should be addressable only by the machinery that manages it, and opaque to everyone else — consumers hold logical tokens; a resolver owns the token→serving map; then layout can change with zero pointer edits.

Two strata deserve first-principles attention because they are where the estate measurably lacks addresses:

- **Parts of a record** (regions with different roles/canonicity/lifecycle inside one document): parts exist and are worked on daily, but nothing *declares* them, so nothing can address them — and demand leaks into whatever surface exists (commit subjects). A part needs to be declared to be addressable; the declaration question is upstream of the address question.
- **Prose**: text is deliberately opaque structure-wise, yet "point at this paragraph" is a real need (provenance, quizzes, edits). Candidate answers differ in contract: structural anchors (identity-ish), word-span anchors (content-ish), offsets (position — weakest). Which contracts prose pointing gets is a design choice, not a given.

Questions:

9. One grammar across containment strata, or per-stratum languages with defined seams? (Note the survey-of-systems finding, held as evidence: native seamless across-forms essentially only exist where the substrate itself is uniform; otherwise one boundary glyph or multi-operand forms are what ships.)
10. What is the logical/physical split *at each stratum*, and which side does each address form speak? Is the union-across-manifestations (one logical store, many physical layouts over its lifetime) a resolver duty by construction?
11. What declares parts, and what contracts does prose-pointing get?

## 5. Resolution is reconciliation, and failure is the payload

The writer minted the pointer under a *belief* about the world; the reader resolves it against the *actual* world. Resolution is therefore belief-reconciliation between parties who cannot converse — and its failure modes are not errors to suppress but **the only channel through which the writer's stale model gets corrected**.

From this, the protocol's shape follows without further assumptions:

- Outcomes are **typed, even on failure**: found-one / found-many (with candidates) / found-none / found-but-stale — because each routes to a different repair (use it / disambiguate / re-derive your model / re-read). Collapsing them teaches the reader nothing.
- The **requested name is preserved beside the resolved thing**, because some consumers need what was asked (emission under the cited name) and some need what was found — discarding either destroys information the act carried.
- **Silent emptiness is forbidden** where the writer's expectation was one — that is precisely the case where the writer most needs to learn — and *graduated dialogue* (proceed? add one? re-think?) beats binary failure wherever a mutation hangs on the answer, because divergence-before-mutation is free teaching and divergence-after is damage.
- **Degradation is a ladder, never a cliff**: automatic when unique; choices surfaced when plural; queued when unattended — with the caller's nature (human/machine) detected, not configured.
- An **expectation attached to the operation** ("I will change {1,N}; I *expect* {1,3}") makes every act a pre-registered probe of the writer's model — the reconciliation made explicit and cheap, and the accumulated divergences are calibration data for free.
- Resolution machinery must read **the primary, not a shadow**: any index or cache it consults is a second store that can disagree with the world, re-importing the very staleness the protocol exists to catch. Where materialization is unavoidable, it carries its own staleness detection.

Questions:

12. Which of this protocol is *library*, which is *convention*, and which — if anything — ever needs language law? (Working hypothesis to test, not assume: the language may need only address *semantics*; the protocol is the product.)
13. Where does the ladder's state live between calls (a pending choice must survive the session that raised it — §0 again)?

## 6. Pointing is usually half of a bigger act

Almost no one points for pointing's sake. The pointer is an *operand* inside: read-this, change-this-to-that, include-that-here-under-this-contract, relate-these-two, verify-this-against-that, "look here" said to a colleague. Consequences:

- The **operation, not the address, carries the act's semantics** — what a miss means, what plurality means, what freshness is required, what must be true afterward. The same address under read and under write has different obligations (a read may be fuzzy; a write must resolve-one-or-refuse and re-verify at write time).
- **Multi-operand forms are first-class**, not a fallback: locate and select and bind as separate operands of a construct compose without any fusion syntax at all — and everything that never gets fused never needs a terminator.
- The **include** is the deepest composite: locate · select · *ascribe* (the inserting site's contract on what arrives — shape, version) · with failure as a *document state*, since a document must remain readable, diffable, and editable while a limb of it is unresolved.
- **Round-trip closure** is the property that makes tools and documents one system: what a tool prints as a location must be valid as the next call's input *and* as document content. If the reading loop and the editing loop speak different address dialects, every crossing is a translation and every translation is a defect site.
- Writing through an address needs a stated **write-back contract** (does a later write supersede wholesale? what does writing through a description mean?) — checkable equations exist for this (the lens laws), and the interaction with a data model where repetition is *accumulation, never overwrite* is a real open corner, not a formality.

Questions:

14. What is the operation inventory the address model must serve (read / write / include / relate / verify / present / remember), and what does each demand of its address operands?
15. Which speech acts are *stored* (references at rest, includes) vs *uttered* (tool calls, prose mentions) — since stored acts inherit the full persistence problem of §3 and uttered ones mostly don't?

## 7. The medium bites back — addresses live inside what they address

A peculiarity most addressing systems never face: here, addresses must be *writable inside the very documents they address*, in a notation where the address's natural characters (`|`, `:`, `[`, `]`, `@`) are the document's own live structure. Three first-principles consequences:

- **Termination is a real problem only under fusion.** An address quoted, enveloped, or split across operands borrows its container's extent; only a *bare fused* address must negotiate with the host grammar about where it ends. So the cost of "paths look native" is exactly the terminator problem, and the design should decide whether that purchase is worth it per context rather than globally.
- **Position can type what syntax doesn't.** In a language whose typing is syntactic-and-positional by principle, a slot whose meaning is "address" (a `:path` key, a tool parameter, a schema selector) can legitimately carry a bare string address — recognition stays ignorant, the consumer knows. Whether that division (bare-where-position-types, self-declaring where it must stand alone or span lines) is one design at two altitudes is a central open question.
- **The document's own reference form should be a true subset** of whatever the tools speak — one language of addressing with a small at-rest dialect, never two languages — or every document→tool crossing becomes §6's translation defect. The subset can stay small forever; what matters is that it is a *subset*, not a sibling.

Questions:

16. Which spelling families exist (quoted / enveloped-self-declaring / bare-positional / multi-operand / at-rest reference), which occasions get which, and what converts between them?
17. What, if anything, must change in recognition itself — and does each candidate change pass the demand-side bar (see §9's authority note) rather than the convenience bar?

## 8. What would count as solved

Not a syntax shipped — a circuit closed. Checkable success properties, each testable with instruments that exist:

1. **One naming, meant everywhere**: an address minted once travels agent→tool→document→human→history without translation loss (walk one address through all the occasions; every break is a finding).
2. **Rot only by chosen contract**: no pointer decays except in the way its declared contract admits — and an audit can find every stored pointer whose contract is weaker than its writer intended.
3. **Misses teach**: a resolution failure leaves the caller knowing more (kind, candidates, repair) than before the call — measured by whether agents' second calls succeed without human help.
4. **Layout freedom**: a store can re-partition, a file can move, an outline can reorder — with zero edits to stored identity-pointers (the natural experiment already ran once: identity references survived a corpus move 18/18 while path-coupled ones rotted 3/109).
5. **The friction canary stays silent**: throw-together remains the sanctioned path; if right-way addressing ever feels heavier than improvising, the design has failed a stated bar (steward observation, held as the gauge to watch, not a law).
6. **First customer served**: verisectorium — simultaneously the richest demand-driver and a live corpus — can name instances, stores, atoms, parts, and views through this design and nothing else.

## 9. Where the prior work bears — evidence and constraint, register-marked

*The corpus enters here, against the derived questions — each item glossed so it means something on this page, and classed by what kind of authority it actually carries.*

**Ruled, binding unless expressly overturned:**

- Recognition is total and never fails on an address — an address in a document is inert text or an inert selector; all failure semantics live above recognition (core law).
- The in-document reference is a frozen three-field selector — name, key, traits — with field-by-field growth forbidden *because wholesale replacement by a real path design was anticipated*. **This work is that anticipated replacement**; the freeze is an inheritance to discharge, not a wall (ledger row "S14").
- Cross-document addressing is in scope by steward mark ("PATH-1"), overruling an earlier document-scope lean; nothing here may foreclose it.
- The 0.9.1 spec is semi-frozen but *expressly open* to demand-driven, parser-facing corrections from exactly this class of work (the "C8" status plus Joseph's addendum).

**Steward statements of decision authority — the frame this session works in:**

- Decisions flow **demand→grammar, never grammar→demand**: 0.9-era spellings were forward-looking guesses whose correction authority belongs to the demand/theory side; what the current grammar *does* is a fact to price, never a verdict — and the observed failure mode is incumbents re-entering through crisp measurements (brainstorms "O14"/"O17", with the recorded specimen).
- **The cheap window for principled invasive change is now** — deferral compounds on consumers, corpora, and imitation ("O18").

**Measured facts (strong, but facts about text-and-parser, not verdicts):**

- The terminator territory is friendlier than feared: inside a bare token nearly every path character is inert; the one hard collision is `]` in exactly two contexts (list items, identity brackets), removable by key-delimiter choice; a marker-free bare address already parses as one value in most value contexts; the envelope spelling is clean everywhere and uniquely has ratified multi-line; multi-operand forms need nothing anywhere (the ~130-case terminator table).
- Two spec/parser divergences gate whole branches and are steward calls: whether `/` continues a *reference* name (decides if `@`-prefixed locate-forms are reachable — and the include sketch pulls that character the other way), and whether the reference bracket is a raw capture or a value slot (decides if the include sketch parses by design or by wire accident).
- Agents address relationally — type-plus-key at any depth — with the tree as storage (one-day sample, honestly flagged); typed-key equality was used, positional access never wanted.

**Shipped prior art (promote, don't reinvent):**

- A working resolution ladder with typed results, kinds-on-failure, aliases, requested-name preservation, and rigidity-classed designators (relata — the estate's deepest addressing implementation, with the 29-duplicate-cluster incident as the measured warrant for never minting on collision).
- The organically-expanding store convention: one base-name, many physical manifestations, identity meaning the union (the NORMS draft) — the layout-invariance demand in lived form.
- Verisectorium's addressing needs as stated by its own brainstorms: instance/store/slug identity addresses, view-relative addresses explicitly second-class, default-collapse chains as ladder rungs, mappings absorbing physical moves.

**Leans and pre-validation observations (inputs; several are this work's job to test):**

- The wire carries references as raw text until multi-segment forms or a structured consumer force the question — *this design is likely the forcing event*, so the lean is an input, not a constraint (operator lean "W3").
- Multi-line policy for remaining delimited forms stays deliberately open, possibly dissolving into capture-owned grammars; the envelope's owned line-span is evidence toward that hypothesis, not license to close it (carve-out "ML").
- The path decomposition sketches — perspective rungs including host/protocol; stem-fuzziness; aspirational-schema designators; suffix-as-return-type; reference syntax reused as the fragment language; the within-project *match* rung with wikilinks as its shipped form ("O13"/"O13a") — pre-validation brainstorms, the richest single map of the outer strata, engaged in §§1–4 rather than inherited whole.

---

*Authored 2026-08-06 as this directory's first artifact; rewritten the same day after the steward's correction — the first version arranged the sources into an arc and flattened their registers into law, which is the confabulation-and-laundering pair this corpus warns about. The derivation (§§0–8) is one agent's reasoning, offered precisely so it can be attacked at the principle level rather than the citation level.*
