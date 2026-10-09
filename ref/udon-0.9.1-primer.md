# UDON for the comparative reader — data model and design commitments

**What this is.** A distillation of the UDON 0.9.1 spec suite (`v2/current-0.9.1-spec/`, ~1,500 lines) for someone who needs to compare UDON honestly against SGML/XML, JSON, YAML, RDF, and the schema languages — without first learning to *write* UDON. It covers the data model, the commitments the design deliberately made and why, and just enough surface syntax to read an example. It is not a tutorial (that is `TUTORIAL.md`) and not the contract (that is `CORE.md`).

**Status, stated honestly.** 0.9.1 is a *consolidation baseline*: one coherent restatement of 0.9-era ruled law, marked **semi-frozen and spec-only** — provisionally frozen, still open to audit-revealed correction, and not necessarily intended to be implemented as-is. Read everything here as **current design commitments**, not as a shipped or eternal standard.

**Where the authority is.** `CORE.md` (surface recognition + core semantics), `MODEL.md` (what recognition produces), `GLOSSARY.md` (every formal term), `SEMANTICS.md` (when two documents mean the same), `CARVEOUTS.md` (what is deliberately unspecified, *with the reason it is open*), `DELTAS.md`, `RATIONALE.md`. Section cites below (`CORE §6.4`, `MODEL §3`) point into those files. **The ruled text is the only oracle** — including for this primer's examples, each of which traces to a ruled section (most are verbatim from `CORE.md`). The repo's reference parser is *not* an oracle and is not used as one here; see §8.

---

## 1. What UDON is, in one screen

UDON is a plain-text notation in which **structure and prose interleave freely at any depth**, with indentation carrying nesting (no closing tags) and a small marker inventory that is live only at the start of a line and while structure is still being written.

```udon
|article[intro].featured :author "Joseph Wecker" :draft?
  |section :title Typed values
    :when <2026-07-11>
    :tags [udon notation]
    Prose lives here, with |{em inline structure} and ;{a note} — # is not special.
```

That parses to: an `article` element with identity `intro`, trait `featured`, a string `author`, a boolean flag `draft?`; a child `section` whose `title` is the multi-word flow value `Typed values`, whose `when` is an *envelope* (a dialect-typed value, unresolved here), whose `tags` is a two-item list, and whose content is one text run containing an inline element and an inline comment.

The design target is a format that humans read without syntax highlighting **and** that agents can generate, stream, repair, and partially write — which is why several of the commitments below are about failure behavior rather than about grammar.

## 2. The data model (the comparative object)

This is `MODEL.md` — the **ADM**, the Abstract Document Model. Recognition (source text → model + anomalies) is the conformance target; everything else is a consumer above it.

```
Document = { content: [Node], anomalies: [Anomaly], result: complete | incomplete-input }

Node    = Element | Text | Comment | Verbatim | Directive | Reference | BlankLine

Element = { name: Name?,                 ; optional — anonymous elements are ordinary
            attributes: [Assignment],    ; ORDERED SEQUENCE, not a map; all precede content
            content: [Node] }            ; ordered, heterogeneous

Assignment = { key: Key, value: Value }  ; exactly one value per assignment

Value   = Scalar | Reference | Interpolation | NodeValue | FlowValue
Scalar  = String | Integer | Float | Boolean | Nil | List | Envelope
NodeValue = Element | Verbatim           ; the attribute IS the node — no wrapper
FlowValue = [Segment]                    ; text runs, inline elements, interpolations, …
```

Five properties are the ones worth carrying into any comparison:

1. **No implicit root.** `content` is a sequence of top-level nodes; multiple top-level elements are true siblings. A document is not required to be a tree with one root.
2. **Attributes are an ordered sequence of assignments, not a map.** Repeating a key is not an error, not an overwrite, and not implicit list-formation — it is two assignments (§4.2). `:x 1 :x 2` and `:x [1 2]` are *never* equivalent, at any layer (`SEMANTICS §2.4`).
3. **An attribute's value may be a node.** `:author |person :name "Jane Doe"` makes the `person` element itself the value of `author`, with no wrapper node. Attributes are labeled edges; edges may terminate at leaves *or* at nodes (§4.4).
4. **Prose is a first-class node kind**, not an escape hatch or a `#text` afterthought, and is **opaque** — Markdown inside text is not interpreted by the core; `#`, `<`, and pipe-space have no meaning there.
5. **Comments and blank lines are in the model**, carried and never interpreted (`MODEL §5`, `§2`). Stripping them is a *view*, not the default.

The model deliberately excludes (`MODEL §8`): any event/wire encoding, reference *resolution*, dialect *projection*, all constraint (schemas judge the model; they never shape it), Markdown semantics, and per-byte span maps.

### 2.1 The text law

> **The document's text material reconstructs by pure in-order concatenation of every Text** (plus flow text segments after inline comments are dropped, with `BlankLine` contributing `"\n"`) — **no fabricated join characters, no re-consultation of the source.** (`MODEL §6`)

Consequences, all normative: each text line's terminator is part of its Text; indentation stripped by dedentation is geometry, not text; inline comments contribute no text but their framing whitespace does; verbatim bodies are exact bytes.

The law's real function is as a **detector**: anything a consumer must consult the source to reconstruct is a model hole. It found one — the 0.9 flat event wire could not reconstruct ownership, and was deratified on that basis. Any future wire encoding is adequate only if the text law is recoverable from it.

### 2.2 Anomalies

```
Anomaly = { severity: warning | error, location, opened_at?, message, code? }
```

Two severities, **defined by loss** (`CORE §14.1`): *Warning* = everything kept, possibly not as intended; *Error* = something was lost, or a value the author clearly intended is genuinely absent. Errors never halt recognition. Whether accumulated anomalies justify dropping, halting, or rejecting is **consumer policy**, never encoded in the model.

Separately, `result: incomplete-input` is a *document-level* fact meaning some delimited construct was still open at true end of input — the "this input was truncated" signal, distinct from per-construct noise.

## 3. Enough surface syntax to read examples

Two ideas predict most of it (`CORE` Appendix A):

- **A line starts open and commits.** Markers are recognized only at *Structure Position* — the start of a line at a structural column, and along the left-to-right run through elements and attributes on that line. The first ordinary prose word ends that state: from there, marker characters are literal. Exactly one carve-out survives commitment — a whitespace-framed ` ; ` opens a trailing comment.
- **Columns are the syntax.** `pop while new_column <= stack_top.base_column`, then push. Deeper = child, same = sibling, shallower = close. Elements written on one line sit at their real columns, so `|a |b |c` is identical to the vertical form.

| Marker | Meaning |
|---|---|
| `\|name` | element |
| `[key]` / `.trait` / trailing `?` `!` `*` `+` | identity / classification / flags — all **sugar** (§4.5) |
| `:key value` | attribute (an edge; phase-gated — attributes precede content) |
| `:key?` | flag key: bare presence means `true` |
| `@name[key].trait` | reference — an inert selector, never resolved by the core |
| `;` | comment (owns everything indented under it) |
| `!name` / `!:lang:` / `!{{expr}}` | directive / block verbatim / interpolation — carried, meaning is a dialect's |
| `` ``` `` | fence — byte-exact verbatim |
| `\|{…}` `;{…}` `!{…}` | inline forms *inside* prose |
| `\` | the one escape: "the rest is text," meaning fixed by **position** alone |
| `<…>` | envelope — the value is handed to a dialect (§4.1) |

Value syntax: `"quoted"`/`'quoted'` strings (no in-string escapes at all — use the other quote kind), integers with `_` separators and `0x`/`0o`/`0b`/`0d` bases, floats, lowercase `true`/`false`/`null`/`nil` *alone at their boundary*, `[space delimited lists]`, and `<envelopes>`. An unquoted token that is nothing else is a string; a multi-word tail is a **flow value** (text with structure segments in it).

## 4. The load-bearing commitments

Each of these is a decision UDON made *against* an obvious alternative, and each has a stated reason (`RATIONALE.md`).

### 4.1 Syntactic typing, a frozen bare set, and the envelope

Type comes from **written syntax, never from sniffing content**. The bare scalar set — string, integer, float, boolean, nil, list — is **closed forever**. Everything else is written inside `<…>` and typed by a *dialect*:

```udon
:when <2026-07-11>                          ; unlabelled — declared dialects bid, first claim wins
:size <u64:0xf902>                          ; type-labelled
:span <temporal:interval:2026-01/2026-06>   ; dialect-and-type-labelled
```

A bare `2026-07-11` is the **string** `"2026-07-11"`. Dates, versions, units, rationals, complex numbers — none are bare, now or ever.

The reason is the failure this is designed against: every format that recognizes values from bare syntax faces continuing pressure to recognize *more*, and each accretion silently retypes documents that already exist (YAML's Norway problem is the canonical case). UDON's defense is **structural, not disciplinary**: dialects act only inside envelopes, so loading one *cannot reach* bare space. Adding types is additive by construction. The cost is visible syntax on every non-core value, paid deliberately.

Interim behavior with no dialect loaded: the envelope's extent still parses, the value is carried as its full lexical form with a warning, and nothing is lost — the same document retypes identically once dialects land.

### 4.2 Stacking, never last-wins

Repeated keys accumulate in order. There is no last-wins anywhere in UDON. The reason: last-wins silently destroys data on the happy path, which contradicts keep-everything on the sad path — and "only one allowed" is a *constraint*, so it belongs to the schema layer, not to recognition. (This is also the ecosystem's one known **silent, backup-proof** YAML corruption mode.) Stacking is also what lets `.a.b` trait sugar be *mere* desugaring into two `$traits` assignments.

### 4.3 Keep-everything, and severity defined by loss

Wherever a coherent "keep and warn" response exists, a conforming recognizer **must** keep the content rather than drop it: unclosed delimited constructs keep what arrived and cite their opener; trailing material after a finished value becomes a further stacked assignment with a warning; a tab in indentation keeps the line as text; an unclosed identity key lands under a *differently named* attribute (§4.6). Silent dropping of author-visible material is non-conformant.

The reason is domain, argued explicitly: JSON wins by rejecting, because its domain is machine-to-machine messages. UDON's domain is documents, prose, streamed LLM output, and half-written files under agent edit — there, rejection converts a small authoring mistake into data loss downstream, and every implementation otherwise invents its own recovery. There is a second, agent-facing reason on the record: sharp, located, typed anomalies are low-ambiguity observations for a consumer that must learn from them — the error channel is a teaching channel.

### 4.4 "Whose name is it?" — attributes as edges, children as nodes

The design test is not "metadata vs content" and not "scalars vs structure":

- an **attribute** key names what the value is *to the element* — `my author`, `my timeout`; it is a labeled edge, and it may terminate at a leaf, at a node, or repeat;
- a **child** names what the thing *is*, and its position matters.

```udon
|book :title "The Craft"
  :author
    |person :name "Jane Doe" :affiliation "Acme Corp"
  |chapter Introduction
  |chapter The Middle Part
```

`author` is an edge whose value is a `person` node; the chapters are ordered children. The explicit claim on the record is that restricting attributes to scalars was **XML residue, not a UDON decision** — once edges may terminate at nodes, the "structure must be a child" pressure disappears and the heuristic collapses into a single question with an answer.

One sharp edge worth knowing (the "one-way door"): once a node value opens, it owns the rest of the line. In `|api :headers |header :k v :timeout 30`, `timeout` belongs to the *header*.

### 4.5 Sugar is designated attributes — no parallel model fields

Identity, traits, and flags are not separate machinery. They desugar, before the model is complete, into ordinary assignments with `$`-prefixed keys:

| Written | Means |
|---|---|
| `\|el[k]` | `\|el :'$key' k` |
| `\|el.a.b` | `\|el :'$traits' a :'$traits' b` |
| `\|el?` | `\|el :'$?' true` |

`|user[jw].admin :active?` and its longhand are **the same element**; implementations must not distinguish them. `$` keys are *designated, not reserved* — any `$` key is legal, and since `$` is not a bare-key character the longhand needs quoting, which is the whole collision defense (convention, not law). Two consequences that matter comparatively: the model stays at *one* concept where XML-descended designs carry three or four (element name, ID, class, attributes), and a dumb generator that only knows how to write attributes can emit full-fidelity documents.

### 4.6 Recognition is total; judgment is layered above it

The layer split is explicit and each layer is forbidden the others' job (`CORE §1.1`):

| Concern | Owner |
|---|---|
| Recognition (text → model + anomalies) | **the core** — the only conformance target |
| What a value *means* / exotic typing | **Dialect** — types, never constrains |
| What is *allowed or required* | **Schema** — constrains, never types |
| Projection to native values | **Host** |
| Reference resolution, duplicate policy, mixins | **Consumer**, choosing from a fixed **menu** |

Three rules keep the split honest: **dialects are not schemas**; **menu vs knob** (the core may fix an option space and a default, and a consumer picks *within* it, never outside); **additivity** (dialects reach only inside envelopes).

Nothing in the model is "invalid." Validity is a predicate a schema applies *to* a complete model, stated separately from equivalence — so a document with warnings is still a document, and two documents can be compared for sameness without either being validated.

**References are inert.** `@licence[mit].realized` recognizes as the selector `(name?, key?, traits)` and stops there; the core never resolves it. Traits on a reference are *selection criteria* — a reference never decorates or mutates its target. Suffixes, attributes, predicates, and nesting are deliberately absent, and the tuple is **frozen at three fields** pending a path language that would replace it wholesale rather than growing it field by field.

### 4.7 Extents, end of input, and bounded lookahead

Every construct declares one of two extent kinds, and new constructs must too:

- **geometric** — closed by end of line, dedent, or end of input (elements, attributes, comments, directives, block verbatim, text blocks);
- **delimited** — closed only by a printed end-sequence (strings, lists, identity brackets, inline forms, interpolations, envelopes, fences).

This makes end-of-input behavior *derivable* instead of enumerated: geometry closes silently (EOF ≡ end-of-line + full dedent; a missing final newline is never an anomaly), while a delimited construct keeps what it has, warns citing its opener, and marks the document `incomplete-input`.

The **fail-safe** is the taxonomy applied where truncation is dangerous: an unclosed `[` on an identity or a reference selector desugars to **`$partial-key`**, not `$key`. A consumer reading `$key` — or resolving a reference — therefore *automatically excludes* a truncated identity instead of acting on it. `$partial-key` and `$key` are never semantically equivalent.

Finally, **bounded lookahead is language law**, not an implementation note: every guard resolves within a few characters, single-level, no unbounded backtracking, and a proposal requiring more is *ill-formed*. The consequence is that a document parses identically whole or byte-at-a-time, and a chunk boundary is never end of input — streamability protected against the language's own future growth.

## 5. Axes for comparison (UDON's answers only)

Offered as axes rather than as a filled-in comparison table — the other columns are the research pass's to write, and pre-filling them would prime it.

| Axis | UDON's answer |
|---|---|
| Prose and data in one document | one grammar; prose is a node kind, opaque to the core |
| Closing delimiters | none — indentation geometry, columns are the syntax |
| Root | no implicit root; top-level siblings allowed |
| Value typing | syntactic, frozen bare set + explicitly-delimited dialect envelopes |
| Type-system growth | additive by construction; cannot retype existing documents |
| Repeated keys | stack, ordered; last-wins does not exist |
| Attribute vs child | "whose name is it"; edges may terminate at nodes |
| Malformed input | keep everything + located anomaly; recognition never halts |
| Truncated input | kept, warned, `incomplete-input`, with a fail-safe rename on identity |
| Constraint / validation | a separate layer that judges the model; nothing is invalid at recognition |
| Cross-reference | inert three-field selector; resolution is a consumer menu, path language deferred |
| Streaming | guaranteed by bounded-lookahead language law |
| Comments | in the model, carried, never interpreted |
| Round-trip | a specified equivalence relation + serializer prohibitions (`SEMANTICS.md`) |
| Extensibility mechanism | dialects (typing) and schemas (constraint), never trading jobs |

## 6. What is deliberately *not* specified

`CARVEOUTS.md` is unusual and worth citing directly in any comparison: every open item travels with **the demand-side reason it is open** and what would close it. It exists because of a measured failure — three independent clean-room rewrites, handed the spec without the reasons, all diligently *closed* an open question in a framing that had already been invalidated ("diligence on a wrongly-framed question produces well-organized irrelevance").

Currently open, with reasons: multi-line policy for the remaining delimited forms (may *dissolve* if bracketed captures turn out to be sugar for dialect-typed captures); nested-envelope routing; the dialect architecture itself — **no dialect spike has ever run**, the largest named hole; the path language; how a document declares its dialects and schema; Markdown layering; mixin semantics; annotation syntax; Unicode identifier version pinning; anomaly-code spellings; and the **event/wire encoding**, which is absent by design after the 0.9 flat wire was deratified.

So: UDON today is a specified *recognition layer and document model* with a stated layering discipline. The dialect layer, schema language, and path language are commitments and constraints, not existing artifacts.

## 7. What is settled versus open, if you need one line

Settled: the model, the marker/escape/geometry rules, syntactic typing with the frozen bare set, stacking, keep-everything with loss-defined severity, sugar-as-designated-attributes, the text law, extent taxonomy, bounded lookahead, inert references, the layer split. Open: everything that requires the dialect, schema, or path designs to exist first.

## 8. Verifying claims and examples

**The ruled 0.9.1 text is the only recognition oracle.** If a comparison rests on what a construct *does*, the answer is in `CORE.md` — for recognition questions the five sections carrying the load are §2.1 (Nesting Rule), §2.2 (Structure Position and commit), §6.4 (the bare-token boundary), §6.5 (ownership), and §14.1 (severity = loss), with `CORE` Appendix C's three worked vignettes showing whole inputs mapped to whole Documents.

**Do not use the repo's reference parser as verification.** It is an old, 0.8-lineage artifact — known non-conformant to the ruled spec, buggy even against 0.8, and *biasing*: consulting it silently converts "what the current implementation happens to do" into "what UDON is," which is the specific mistake this project has had to correct repeatedly. Its output is admissible only as an explicitly labeled "what the old parser does" fact, never as evidence about the language.

There is a real hazard on the other side, worth naming rather than papering over: **reading the spec whole buys comprehension but not conformant generation** — agents who had read the entire suite the same day still emitted plausible-but-wrong UDON. The defense is not a parser run; it is citing the section at the point of use, and preferring the spec's own examples over freshly invented ones (as this primer does).

---

## Appendix — notes back to the UDON side (not for the research reader)

Observations from this distillation pass, offered as by-product; none is a verdict.

1. **Which node kinds begin content phase is unstated (spec-side, stands alone).** `CORE §6.9` says content phase begins with "a child, text, or a sameline tail." `MODEL §2` gives seven node kinds. Read literally, §6.9 says a **reference** child — a node in `content` — closes the attribute window, and the same question applies to verbatim and directive children; a comment or blank line surely must *not* (they would make `; note` between attributes a phase break). The spec never enumerates. One sentence naming the kinds would close it. *(A parser observation pointed me here, but the ambiguity is in the text and needs no implementation to see; the parser fact is not evidence and is omitted.)*
2. **`CORE §1.1` lists three "boundary rules" and then gives two headings** (menu-vs-knob, dialects-are-not-schemas, additivity — the third is separated by a blank line and reads as an afterthought). Cosmetic, but the sentence promises three and the layout hides one.
3. **`SEMANTICS §2.3` and §3 interact quietly.** Integer base-spelling normalization is explicitly "not round-trip safe by design," while §3 requires a faithful serializer to preserve recognition identity "up to integer base spelling." Consistent on a careful read; a reader skimming for round-trip guarantees could easily take away that base spelling is preserved.
4. **No carve-out covers "what a schema language must be able to say."** Constraint is assigned to the schema layer in four separate places (`CORE §1.1`, §6.7, §11.1, `MODEL §8`) as the destination for cardinality, uniqueness, and `$key` multiplicity — but `CARVEOUTS.md` has no SCHEMA entry with a demand-side reason and closing condition the way PATHS and DIALECT-DEF do. Given how much the core defers *to* it, its absence from the register is conspicuous.

*Written 2026-07-29 as the first artifact of the format-failures research thread. Sources: `v2/current-0.9.1-spec/` (all nine files, read whole). Every snippet traces to a ruled section — most verbatim from `CORE.md`; the `|book` node-value example is derived from §6.2 (deferred body), §6.8 (node value), and §2.1 (the dedent that makes the chapters children). No claim here rests on the reference parser.*
