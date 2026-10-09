# The terminator stress table

**What this is.** The probe the paths ideation seed §2g names as "the highest-value unbuilt thing," run: for each path-shaped spelling, in each real 0.9.1 value context, where does the expression end? A *mechanics* first pass. It decides nothing about which path syntax UDON should have, and where it touches design it says so and stops.

**How far to trust it.** ~130 hand-chosen cases, not a generated sweep — chosen from the demand map's stress list plus what earlier cases surfaced, so the coverage is as good as my case-selection and no better. Findings that follow from CORE's text are marked as such and are as strong as my reading of it; findings that only reflect the current parser are marked and are not language facts at all. Limits and falsifiers are in §9; everything is reproducible from `scratch/`.

---

## 1. Findings

Support-state is in each sentence. **Derived** = follows from 0.9.1 CORE text (section cited). **Probed** = the 0.9.0-alpha.2 reference parser agrees. **Parser-only** = current-parser behavior in territory CORE leaves open — descriptive, never language behavior (ratified framing rule S2).

**F-1. The collision the demand map anticipated is at `]`, not at `|`.** Derived from §6.6 and probed: once a bare token has started on an element-rooted line, a block attribute line, inside `|{…}`, or inside `<…>`, the terminator set is *space and EOL only* — `| : . @ [ ] < > # / *` are all ordinary token content there. The exception is **list items and identity/selector brackets**, where `]` terminates unconditionally and is not depth-counted (§6.6 for lists, §5.3 for identity), while `[key]` is the path's own key syntax. So bare paths using `[key]` break in those two contexts and survive in the other four. Everything below is downstream of this.

**F-2. A path spelled without a leading marker character parses today as a single value, in four of six contexts, with no grammar change.** Derived (§6.4 boundary + §6.6 terminators) and probed: `intent[311].a.b:fed-by@:health` is one bare token (a String) on an element-rooted line, on a block attribute line, inside `|{…}`, and inside `<…>` — and a following `:host x` still parses as a normal attribute. It breaks in list items and identity brackets for F-1's reason. The seed lists three candidate futures; this is a fourth, and it is the cheapest thing measured here. Whether it is *desirable* — a path recognized as a String, typed by position rather than syntax — is a design question I did not settle (§7 has the argument and its counter-case).

**F-3. `<path:…>` requires no new recognition grammar in any of the six contexts.** Probed in all six; derived from §11.6. It carries `|` `:` `[` `]` freely, nests (`<path:||intent[<u64:311>]:status>` — typed keys with no added rule), and self-terminates so the Line Scan continues. Two constraints, stated rather than weighed: an **unbalanced `>` closes it early** (derived + probed), which is the character an attr-value comparison predicate wants — the demand map records that filter wanted ~4× in one scenario day; and it depends on a dialect layer that does not exist (CARVEOUTS **DIALECT-DEF**, **ENV-ROUTE**), so today every such value warns `NoDialectsLoaded`.

**F-4. The `|a|b|c` tree-path spelling is character-identical to the language's own sameline nesting.** Derived (§2.1, §6.8) and probed: `:p |article|section|para` is three nested elements, and a following `:host x` goes to the innermost via the one-way door. Similarly `|*.trait` is already a well-formed anonymous element carrying the `*` flag suffix (§3's guard admits `? ! * +`; §5.4/§5.5). Both are statements about what those characters currently mean, not arguments about what a path language should choose.

**F-5. Two routes give an unquoted bare path today with no grammar change, and neither was on the seed's list.** Derived (§4, §6.5) and probed: the value-position escape (`:p \` then the path — flow text for the rest of the line) and the deferred value body (`:key` ⏎ the path on a deeper line). Limits are located in §5.5–5.6. Their significance is evidential rather than prescriptive: a bare path is *already writable* in the contexts where paths mostly live.

**F-6. The `]` blocker is removable by changing the key delimiter, at no measured grammar cost.** Probed across all six contexts: `(…)` works everywhere; `{…}` works in lists and brackets but closes `|{…}` early; `[…]` fails in exactly F-1's two contexts. Whether departing from `[key]`'s mirror-the-document rationale is worth it is the spike's call — it is now priced, not resolved.

**F-7. Two grammar/CORE divergences gate large parts of the territory, and both are steward calls.** Whether `/` continues a **reference** name (CORE §5.2 says names take `/`; the grammar's reference class omits it while the element class includes it) determines whether `@`-prefixed path-*to* is reachable at all. Whether the `@[…]` selector bracket is a **raw capture or a value slot** (CORE §5.3 says value rules; the grammar scans raw to the first `]`) determines whether Joseph's include sketch genuinely parses or only appears to. Reported three-way in §6, no verdict, per the house rule.

**One negative result.** Across the cases run, no collision required more than one character of lookahead — so §2.3's bounded-lookahead law was not the binding constraint here. That is a statement about the cases I chose, not a proof over the space.

**One thing I expected to need and did not.** The seed calls for a descent prototype to force the table. None was built and no grammar regenerated: every collision resolved against existing law plus the existing parser, and the two cells needing new grammar need it for a ruled reason (§6.6's unconsumed `]`) that a prototype would re-demonstrate rather than test. The prototype is still right for the one thing this pass could not reach — §9.4.

---

## 2. How to read the cells

| Mark | Meaning |
|---|---|
| **[L]** | Derivable from 0.9.1 CORE, section cited — as strong as my reading of it. |
| **[P]** | **PINS CURRENT PARSER** (0.9.0-alpha.2). Descriptive only; never cite as language behavior. |
| **[L≠P]** | CORE and parser differ. Three-way, no verdict — which resolution applies is a spec-reasoning call. |
| **[L?]** | CORE is genuinely underdetermined. Named, not filled. |

Law read whole before any case was written: `v2/current-0.9.1-spec/` CORE, CARVEOUTS, GLOSSARY, DELTAS. None of DELTAS' eleven rows touches value-position termination, so the alpha.2 parser is a fair instrument — with [P] never promoted to law.

---

## 3. The six contexts

CORE §6.6 gives four explicitly; the paths question forces in two more.

| # | Context | Bare-token terminators | Tail after a finished value | Source |
|---|---|---|---|---|
| **C1** | Element-rooted line | space, EOL | element's content (ownership row 2) | §6.6 [L] |
| **C2** | Block attribute line | space, EOL | warned extension (`AttributeSecondValue`) | §6.6, §6.7 [L] |
| **C3** | Inline element `\|{…}` | space, EOL, `}` (unconsumed) | inline element's content | §6.6 [L] |
| **C4** | List item `[…]` | space, EOL, `]` (unconsumed) | *(items have no tails)* | §6.6, §11.5 [L] |
| **C5** | Identity / selector bracket `[…]` | **absent from §6.6's table**; `]` closes (§5.3 — unclosed ⇒ `$partial-key`), space/EOL by parallel with C4 | *(n/a)* | §5.3 [L, by parallel]; [P] agrees |
| **C6** | Envelope interior `<…>` | *none at core* — only the `<>`-balanced span is guaranteed | *(n/a)* | §11.6, CARVEOUTS ENV-ROUTE [L] |

Two further places a path lands — not §6.6 contexts, but real and probed:

| # | Place | Behavior | Source |
|---|---|---|---|
| **C7** | Deferred value body (`:key` ⏎ deeper lines) | flow text under content-base rules — **except** a line opening with block-form `\|`/`!`/fence, which binds as a node value | §6.5, §6.8 [L] |
| **C8** | Verbatim (`!:label:`, fence) | opaque; nothing terminates but the form's own closer | §10 [L] |

**The asymmetry that matters most for paths** is C1 vs C2 (§6.5, *Collecting*): on a block attribute line the attribute keeps collecting past its finished value (further material ⇒ warned extension under the key); on an element-rooted line the element takes the tail. The same path text therefore mis-parses into different shapes in the two contexts — and only C2 warns.

---

## 4. The table

### 4.A What happens today

`✅` the whole path survives as one value · `⚠️` survives with an anomaly or shape change · `❌` silently broken into other structure.

| # | Spelling | C1 element-rooted | C2 block attr | C3 inline `\|{…}` | C4 list item | C5 identity `[…]` | C6 envelope |
|---|---|---|---|---|---|---|---|
| **S1** | `"\|\|intent[311]:status"` *(today's corpus)* | ✅ String [L] | ✅ [L] | ✅ [L] | ✅ [L] | ✅ String key [L] | n/a |
| **S2** | `<path:\|\|intent[311]:status>` | ✅ one value + `NoDialectsLoaded` [L] | ✅ [L] | ✅ [L] | ✅ [L] | ✅ [L] | — |
| **S3** | `@config\|database[primary]` | ❌ `db=@config`; `\|database` becomes a **child element** and takes the rest of the line (§6.5 row 2 + §6.8 one-way door). **Silent.** [L] | ⚠️ `db=@config`, then `AttributeSecondValue` + the node stacked under `db` [L] | ⚠️ ref `config` + text `"\|database"` (bracket mode, §5.6) [L] | ❌ two items: ref `a`, bare `"\|b"` [L] | ❌ `$partial-key` + `UnclosedIdentityKey`; `\|database` opens an element [P] | ✅ inert |
| **S4** | `@config:database` | ❌ ref `config`; `:database` opens a **sibling attribute** ⇒ `MissingAttributeValue` **Error** [L] | ❌ same [L] | ❌ same [L] | ❌ splits | ❌ breaks | ✅ inert |
| **S5** | `\|\|intent[311]:status` | **[L?]** underdetermined at value-start (§5.1). [P] splits: text `"\|"` + a real element `intent` | **[L?]**; [P] one Text value — *and disagrees with C1* | ⚠️ [P] text, correct content, two segments | ❌ `]` closes the list mid-path [L] | ❌ `]` closes the bracket [L] | ✅ inert |
| **S6** | `\|article\|section\|para` | ❌ **three nested elements**; a following `:host x` goes to the innermost [L] | ❌ node value, same nesting [L] | ⚠️ only `\|{` is an inline form; bare `\|` is text [L] | ❌ bare items | ❌ breaks | ✅ inert |
| **S7** | `intent[311]:status` *(no leading marker)* | ✅ **one bare token (String)**; `:host x` after it works [L §6.4/§6.6] | ✅ [L] | ✅ `}` terminates cleanly [L] | ❌ `]` closes at `intent[311` [L] | ❌ `]` closes [L] | ✅ inert |
| **S8** | `@@intent(311):status` *(non-marker sigil + paren key)* | ✅ [L] | ✅ [L] | ✅ [L] | ✅ **[L]** | ✅ **[L]** | ✅ |
| **S9** | value-`\` then `\|\|intent[311]:status` | ✅ flow text, **line-final**: a following `:host x` is swallowed into it [L §4] | ✅ flow text; next block line is a normal attribute — no cost [L] | ✅ bounded by `}` — **[P]**; CORE silent (§5.6) | ❌ `\` is literal content, not an escape [L §4 — value-expected position only] | ❌ same [L] | n/a |
| **S10** | `⊤/spec/CORE.md#\|\|section[nesting-rule]` *(fused, no `@`)* | ✅ one bare token [L] | ✅ [L] | ✅ [L] | ❌ `]` | ❌ `]` | ✅ |
| **S11** | `@⊤/spec/CORE.md#\|\|section[…]` *(fused, with `@`)* | ❌ ref stops at `⊤`; `\|section` opens an element [P; `/` is [L≠P] — §6 D-a] | ❌ | ❌ | ❌ | ❌ | ✅ |
| **S12** | `@[core://components/another.udon # main-findings]` | ✅ **one Reference**, whole bracket raw incl. spaces, `//`, `#`; `:host y` after it works **[P]** — but see §6 D-d | ✅ [P] | ✅ [P] | — | — | ✅ |
| **S13** | `!{{ at(intent[311]:status) }}` | ✅ Interpolation, carried unparsed [L §9] | ✅ [L] | ✅ [L] | ✅ [L §11.5] | — | ✅ |

Reading **down a column** is more informative than across. C6 is a column of `✅`. C1 and C2 differ from each other on S3 and S5. C4 and C5 are `❌` for every bare form using `[key]` and `✅` for every form that doesn't.

### 4.B What each candidate future would require

"nothing" = no change to recognition. F1–F3 are the seed's; F4–F5 emerged from the mechanics (§1 F-2, F-5).

| Context | F1 stay quoted | F2 `<path:…>` | F3 bare `@`/`\|` multi-segment | F4 no leading marker | F5 `\`-forced |
|---|---|---|---|---|---|
| **C1** | nothing | nothing *(recognition)* | **new rule**: a `\|`/`:` abutting a reference tail must continue it rather than open a node/attribute — resolvable in 1 char, but it **retypes existing documents** (S3 means something today) | nothing | nothing, but line-final |
| **C2** | nothing | nothing | same, plus suppressing today's `AttributeSecondValue` | nothing | nothing |
| **C3** | nothing | nothing | **smaller** — bare `\|` is already text here (§5.6), so only the ref-tail continuation is new | nothing | **[?]** whether `}` bounds `\`-forced text is CORE-silent (§5.6) |
| **C4** | nothing | nothing | **hard**: `]` must become depth-counted inside a path segment, against §6.6's "`]` (unconsumed)" — or the key delimiter changes | **hard**, same `]` | unavailable |
| **C5** | nothing | nothing | **hard**, same `]`, and it entangles the `$partial-key` fail-safe (§5.3) | **hard**, same `]` | unavailable |
| **C6** | n/a | *is* this future | n/a | nothing | n/a |
| **C7** | ❌ **quotes are literal** on a body line [L §6.5] | ❌ **angles are literal**, same reason | `\|`-leading binds as a node (§6.8); `\|\|`-leading is text | nothing | nothing (the body *is* text) |
| **C8** | nothing | nothing | nothing | nothing | nothing |

F3's cost is not distributed: it concentrates in two cells, and both are the same `]`.

---

## 5. The mechanics behind the cells

### 5.1 `||` at value-start lands on a CORE seam

`:p ||foo`. The first `|` is followed by `|`, not in the guard set (§3), so the guard fails. §3 then says the character "is ordinary text, and the … value's fate is decided as if it were any other character" — which at value-start starts a bare token, terminating at space/EOL (§6.6): the String `"||foo"`. But §6.4's failed-guard sentence ("*a lone `|` … commit the flow value together with the token before them*") is written for the after-a-token case, and at value-start there is no token before. Two readings; no rule choosing between them. **[L?]**

The parser does neither, and does two different things:

| | Input | Parser result |
|---|---|---|
| C1 | `\|el :p \|\|foo` | `Text "\|"` then a real `ElementStart foo` **[P]** |
| C2 | `\|el` ⏎ `  :p \|\|foo` | one `Text "\|\|foo\n"` **[P]** — disagrees with C1 |

Grammar: `20-udon.attributes.descent.udon:91`, state `:value_start`, routes `|c['|'] | result = NODE` **unguarded**, whereas the bare-token boundary states (`30-udon.values.descent.udon:208`, `:371`) do apply the full guard set. The guard is applied at a token boundary and not at value-start. *Consequence for paths:* `||` is the one spelling among the seed's candidates sitting on an open seam, so choosing it would mean closing the seam first.

### 5.2 `]` (the F-1 mechanism)

In C4, §6.6 lists `]` as an unconsumed bare-token terminator. In C5, §5.3 makes `]` the identity closer. Neither is depth-counted — `[` inside a bare token is ordinary content (§6.4: `[` is not a boundary marker), so no depth is ever raised to match.

```
|el :xs [intent[311]:status other[1]]
;        └ item = "intent[311"   └ the ] CLOSES the list here
;        then ":status" becomes an ATTRIBUTE of el, and "other[1]]" its value
```

Same for identity brackets. Quoting the *segment* does not help (`intent["311"]` still ends at the `]`); only quoting the whole path does. **[L]**, [P] agrees.

Key-delimiter sweep, all probed:

| Key delimiter | C1 | C2 | C3 inline | C4 list | C5 identity |
|---|---|---|---|---|---|
| `[311]` | ✅ | ✅ | ✅ | ❌ | ❌ |
| `{311}` | ✅ | ✅ | ❌ *(brace balance closes `\|{…}` early)* | ✅ | ✅ |
| `(311)` | ✅ | ✅ | ✅ | ✅ | ✅ |
| `/311` or `=311` *(no delimiter)* | ✅ | ✅ | ✅ | ✅ | ✅ |

**[L]** — none of `(`, `)`, `=`, `/` is a marker or terminator in any context; `{`/`}` are, in C3 only.

### 5.3 What a bare token tolerates

Across the cases run in C1/C2/C3, once a token has started these were all ordinary content: `:` `.` `[` `]` `@` `#` `/` `<` `>` `*` `=` `(` `)` `|` `~` `%` `^`. A token that starts as a number or keyword and goes wrong falls through to String token-locally (§6.4): `311[a]` and `true[a]` are the Strings `"311[a]"`, `"true[a]"` — so numeric-looking and keyword-looking first segments are safe. **[L]**, [P] agrees on all.

What *breaks* a bare token is closed by law rather than by my sampling (§6.6 fixes the terminator sets): space, EOL, a framed ` ; `, plus `}` in C3 and `]` in C4/C5. Characters that cannot *start* a value without being something else: `| : ! ; @ ` `` ` `` `\ < [ " ' + -` and digits. Free starters include `# % & ~ ^ * . = /` and every letter — probed for `# % ~ ^ @@ //` in C1–C5.

### 5.4 The envelope's `>` (the F-3 constraint)

`<…>` closes on the matching `>`, depth-counted (§11.6), so nesting is free:

```
|el :p <path:||intent[<u64:311>]:status>     ; ✅ whole thing, one value
|el :p <path:||intent[311:status>            ; ✅ an unbalanced [ is inert
|el :p <path:||intent[age>30]>               ; ❌ closes at the > in "age>30"
```

**[L]**, [P] agrees. Repairs available if predicates land: spell the operator without `>` (`gt`), quote the operand, or nest (`<gt:30>`).

The envelope is also one of only three **ratified multi-line** delimited forms (§13.2, with `|{…}` and the fence) — a long path may wrap inside `<…>` with the newline as content, *guaranteed*. Every other candidate's multi-line status sits inside the **ML carve-out** and must not be relied on: quoted strings currently span the newline **[P interim]**; lists and identity brackets close at it with a warning **[P interim]**.

### 5.5 The deferred-body route (F-5a)

```
|el
  :p
    ||intent[311]:status        ; ⇒ p = the text "||intent[311]:status"
```

Body lines of a deferred value are flow text under content-base rules (§6.5), so markers are inert — no quotes, no escape, no grammar. **[L]**, [P] agrees. Three limits:

1. A body line opening with a guard-confirmed block-form `|` **binds as a node value** instead (§6.8) — `||`-leading and marker-free are safe; single-`|`-leading is not.
2. A continuation line beginning `:` is the **attribute-under-attribute Error** (§6.8/§14.1) — a path cannot be wrapped by breaking before an attribute step.
3. Quoted and envelope forms are **literal** in a body (`"||a"` keeps its quotes) — a body-line path must be bare.

### 5.6 The value-`\` route (F-5b), and a CORE silence

`\` in value-expected position is consumed and the value becomes flow text for the rest of the physical line (§4), surrendering the framed-comment affordance:

```
|el
  :p \||intent[311]:status      ; ⇒ p = "||intent[311]:status"   ✅
  :host x                       ; ⇒ unaffected
```

Because the comment affordance is surrendered, this is the only context in which a bare path may contain a framed ` ; ` (probed: `\||intent[a ; b]:status` survives whole). On an element-rooted line it is line-final, which makes it in practice a block-attribute-line idiom — where paths mostly live.

Inside `|{…}` the parser bounds `\`-forced text at `}` **[P]**. CORE §4 says "the rest of the physical line" and does not carve `}` out; §5.6 says `}` closes the inline element. **CORE is silent on which wins** — and §6.6 already flags a neighbouring unspecified edge (a framed ` ; ` after value-`\` text inside an inline element). One sentence would close it; this probe did not.

In C4/C5 `\` is not an escape at all (no value-expected position there): `[\||a|b]` yields the literal bare token `"\||a|b"`. **[L]** (§4 position table), [P] agrees.

---

## 6. Divergences (three-way, no verdict)

| # | Point | CORE says | Grammar does | Parser does |
|---|---|---|---|---|
| **D-a** | `/` in a **reference** name | Names' continue-set includes `/` (§5.2); references select by name (§12.2) ⇒ `@acme/widget` is one reference | `90-…references:19` / `30-…values:161` use `<XLBL_CONT '.'>` — **no `/`**; the element-name state (`10-…elements:414`) uses `<XLBL_CONT '/'>` | `@acme/widget` ⇒ `Reference "acme"` + text `"/widget"`; `\|acme/widget` ⇒ one element named `acme/widget` |
| **D-b** | Value-start failed-guard `\|` | Underdetermined (§5.1) | `:value_start` routes `\|`→NODE unguarded; boundary states apply the guard | C1 splits into text + element; C2 makes one flow value; the two disagree |
| **D-c** | `@` guard and `'` | §3 admits `[`, `.`, identifier-start after `@` — **`'` is absent**, though the `\|` guard admits it | follows CORE | `@'weird name'` is plain text, not a reference |
| **D-d** | Selector-bracket interior | "the normal value rules" (§5.3) ⇒ `@["a]b"]` is the string key `a]b`; `@[core:// x # frag]` is not one value | `->[']']` — raw scan to the **first** `]`; interim raw-text-after-`@` wire (W3, CARVEOUTS §W) | `@["a]b"]` ⇒ `Reference "[\"a]b"` + trailing text; `@[core://x.udon # frag]` ⇒ one Reference carrying the whole bracket |
| **D-e** | Multiple identity brackets | not specified; OPEN S3 (Joseph lean: valid, design with paths) | first bracket only | `@a[1][2]` ⇒ `Reference "a[1]"` + text `"[2]"` |
| **D-f** | `\`-forced text vs `}` in `\|{…}` | silent (§5.6) | `:blob` is brace-balanced in embedded context | `}` bounds the forced text |

**D-a and D-d bear directly on paths** (F-7). D-a decides whether `@`-prefixed path-*to* is reachable. D-d decides whether `@[…]` is a ready-made self-delimiting container or a value slot — and therefore whether Joseph's include sketch parses by design or by wire artifact. Neither is an agent's to settle.

*On S14 (the frozen three-field selector):* nothing here proposes growing the tuple. The probe adds one cost fact — the tuple's bracket is already a raw capture in practice **[P]**, so "wholesale replacement" has a cheap landing site: the interior grammar could change without the surrounding recognition changing. That is about cost, not direction.

---

## 7. Measured cost per candidate future

Costs only. Ranking them would require weighing legibility, pedagogy and the dialect roadmap against grammar cost — none of which this probe measured.

| Future | Recognition cost | Contexts clean | Constraints found |
|---|---|---|---|
| **F1** quoted | zero | C1–C5 | quote-kind exhaustion under L2 (no in-string escapes — a path with both quote kinds is unwritable; a typed string key must use the inner kind); wrapping unavailable-or-interim (ML); **fails in C7** (quotes literal); stays opaque on the wire, so consumers re-lex |
| **F2** `<path:…>` | zero, all six | all six | unbalanced `>` (§5.4); fails in C7 (angles literal); **blocked on DIALECT-DEF / ENV-ROUTE**, warns `NoDialectsLoaded` meanwhile; uniquely has ratified multi-line |
| **F3** bare `@`/`\|` | one continuation rule in C1–C3 (1-char); `]` in C4/C5 | — | retypes existing bare space (S3 means something today); `\|a\|b\|c` and `\|*.trait` are existing forms (F-4); `@`-prefix breaks at `/` (D-a), at `:`, and at `\|` |
| **F4** no leading marker | zero in C1, C2, C3, C6, C7, C8; with `(…)` keys, zero in all six | 4 of 6 (6 with `(…)`) | space and framed ` ; ` break it, as for any bare token; the path is a String at recognition |
| **F5** `\`-forced / deferred body | zero | C1–C3, C7 (`\`); C7 (body) | line-final in C1; unavailable in C4/C5; `}`-bounding is CORE-silent (D-f); body form must be bare |

**The one design argument I will make, marked as argument.** *(Proposed reasoning, not a measurement; I may be wrong.)* The expected objection to F4 is "then a path is indistinguishable from a string." Worth checking whether that is an objection at all: CORE §11.1 already fixes that type comes from written syntax and never from sniffing, and the bare set is closed forever. A path recognized as a String and given meaning by its *position* — the `:path` key, a tool's parameter slot, a schema selector — is that principle operating as designed. On that reading F2 and F4 are not rivals but one design at two altitudes: bare where position types it, enveloped where it must self-declare. **The counter-case that would break this**, which I did not test: a path in a genuinely untyped slot — a free-standing list of mixed strings and paths — where F4 gives the reader nothing and F2 gives them everything.

**What would actually decide F2 vs F4** is legibility to agents and humans — a different experiment (`ux/TODO-AGENT-UX.md`), not derivable from anything here.

---

## 8. The fused locate+descend extension

Joseph's include sketch `@[core://components/another.udon # main-findings]` (living-documents §1b — syntax explicitly random, no lean), plus §0's "across" composition. Probed rather than reasoned:

| Form | Result |
|---|---|
| `:p @[core://components/another.udon # main-findings]` | ✅ **one Reference**, whole bracket raw — spaces, `//`, `#` and all — and `:host y` after it works **[P]**; under CORE's value rules this should not hold (D-d) |
| `:p ⊤/spec/CORE.md#section[nesting-rule]:title` *(no `@`)* | ✅ one bare token; `:host x` after it works **[L]** |
| `:p @⊤/spec/CORE.md#\|\|section[…]` *(with `@`)* | ❌ shatters at `/` (D-a) and again at `\|` |
| `\|include :from ⊤/… :select "\|\|section[…]"` *(multi-slot)* | ✅ nothing is fused, so nothing needs a terminator **[L]** |
| `\|include :from <url:…> :select <path:…>` | ✅ **[L]** |

Which futures the extension leaves available, measured:

- **F2** — available and extends without new grammar; the label ladder (§11.6) already has the right shape for locate/descend/both, and nesting means `<include:<url:…> <path:…>>` needs no rule.
- **F4** — available **provided the fused expression does not begin with `@`**. `⊤/…#…[…]` is one token; `@⊤/…` is not. So the extension turns on **D-a**, an unresolved divergence rather than a design choice.
- **F1** — available; ML makes long fused addresses awkward to wrap, and fused addresses are the longest ones.
- **F3** — needs `@`-prefixed multi-segment, which needs D-a resolved toward `/`-continues, which then puts the filesystem `/` and the namespacing `/` (seed §2a, flagged *sharp*) into one character class. F3 and the include primitive pull that character in opposite directions.
- **Multi-slot** — needs nothing, in any context, and composes with F1/F2/F4 for its operands.

At the recognition layer every form above already satisfies "a failed include is a document state, not an exception" (living-documents §1b): a path is inert text or an inert selector, and nothing in this table can make recognition fail. The read-membrane failure mode lives entirely above recognition.

---

## 9. Limits, and what would change these findings

**Limits of the instrument.**
- ~130 hand-chosen cases. Negative claims ("X is safe everywhere") are as good as my case selection — except where noted as closed by law (§5.3's terminator sets are §6.6's, not my sample's).
- The parser is 0.9.0-alpha.2. DELTAS' rows don't touch value termination, but a divergence I attributed to the parser could in principle be a consolidation artifact.
- I read the grammar only where parser and CORE parted. A divergence neither my cases nor my CORE reading surfaced is invisible here.
- Every [L] cell is my reading of CORE. §5.1 is direct evidence that CORE can be read two ways in this area.

**What would falsify the main findings.** F-1 and F-2 fail if §6.6's terminator sets are read differently than I read them, or if a context exists that I missed. F-3 fails if the dialect layer, once designed, claims the envelope interior in a way that constrains what a path may contain. F-6 fails if `(` or `=` acquires meaning in a future ruling.

**Open after this pass.**
1. **D-a and D-d** need steward rulings before F3, F4-with-`@`, or the include primitive can be evaluated.
2. **`[key]` vs `(key)`** is now a priced fork: mirror-the-document at the cost of two contexts, or universality at the cost of the mirror.
3. **The predicate/`>` collision** (§5.4) is worth carrying into the dialect work now rather than discovering later.
4. **The one thing a descent prototype should still measure:** whether F3's continuation rule can be added without regressing existing fixtures. That is a measurement, and a natural first hour of the paths spike.
5. **Untouched here:** stacked-attribute access, `at`/`all` cardinality, sugar-aware writes (demand map §3.3, D4, §8). This table is about where an address *ends*, not what it selects.
6. **ML stays open and should stay open** (CARVEOUTS ML). Nothing here is pressure to close it per-construct; F2's advantage over F1 — its line-span owned by its own capture grammar — happens to be ML's dissolution hypothesis, which is an observation, not a closing argument.

---

## Appendix A — spec-side observations

Not defects claimed; observations a paths ruling would want on the table.

1. **The `@` guard omits `'`** while the `|` guard includes it (§3; D-c). An element whose name needs quotes (`|'weird name'`) is therefore unreachable by reference today. Since `ref ⊂ path` is the ruled direction, a path language inherits the hole unless the guard widens.
2. **§6.6's context table has no identity/selector-bracket row** (C5). Its terminators are derivable by parallel with C4 and [P]-confirmed, but the table is the natural home — and C5 is one of the two contexts where every bare-path future breaks.
3. **Value-start failed-guard markers are underdetermined** (§5.1) — the one place a `||`-spelled path would need law before it could be evaluated.
4. **`\`-forced text vs the `}` of an enclosing inline element** is silent (§5.6), adjacent to an edge §6.6 already flags.
5. **Quoted paths inherit L2 fully** — no in-string escapes, so `"||intent['0042']"` ✅ while `"||intent[\"0042\"]"` yields literal backslashes **[L]**.
6. **The paths↔ML dependency runs paths → ML**, per CARVEOUTS ML's own reasoning, not the reverse.

## Appendix B — notes against the ideation seed

Aside weight: mechanical observations where the seed's §2 tables carry a proposal. Input to the spike, not corrections.

- **§2e's `|*.trait` wildcard** ("removes the P3/P4 ambiguity with no new symbol"). Mechanically the symbol isn't free: `|el :p |*.intro` parses today as an anonymous element with `$* = true` and `$traits = "intro"`, because the `|` guard admits the flag-suffix characters `? ! * +` (§3) and `|*` is then a well-formed flag-suffixed anonymous element (§5.4/§5.5). **[L]**, [P] agrees. Via `@` the spelling is not just taken but unreachable — `@*` fails the `@` guard, so `@*.intro` is the ordinary bare string. Under F4 the wildcard needs nothing: `*[311]:status` and `.intro:title` are plain bare tokens in C1/C2/C3/C6.
- **§2b's relational-first lean** is untouched by this probe — `||`'s any-depth *semantics* are orthogonal to where the expression ends; only the `||` *spelling* is affected (§5.1).
- **§2g's three futures** are costed in §7; the two additions are F4/F5.
- **§0b's multi-slot form** ("likely the cheapest and most-precedented") is confirmed mechanically as needing nothing in any context (§8) — the seed's guess, now measured.
- **§9's trap list** was honored: `design/udon-paths.md` was not read, and no bracket semantics were inherited from it.

## Appendix C — case index

All in `scratch/`. Cases labelled `#= <id> <description>`; outputs pair line-for-line.

| File | Covers |
|---|---|
| `cases-A` / `out-A` | The demand map §4 hand table, run: `@`-multi-segment in C1–C6, quoted baseline, envelope, identity bracket, `⊤` sigil, the fused sketches |
| `cases-B` / `out-B` | Divergence isolation (`\|\|` in C1 vs C2, `/` in names, `@`-guard), the value-`\` route, `@[…]` raw capture, envelope stress (nesting, newline, `>`), quoted-path L2 consequences |
| `cases-C` / `out-C` | Element-name `/`, quoted selector interiors, `\` inside `\|{…}`, multi-key, interpolation containers, deferred bodies, verbatim/fence, bare-token tolerance, multi-slot forms |
| `cases-D` / `out-D` | The marker-free result across all six contexts; the `]` law isolated; deferred-body node-vs-text; numeric/keyword first segments |
| `cases-E` / `out-E` | `\` in bracket contexts; quoted/envelope in deferred bodies; ML interim behavior; `\|a\|b\|c` as nesting; leading `!`/`;`/backtick |
| `cases-F`, `cases-G` | Non-marker sigils (`@@ ~ % // ^`) and the key-delimiter sweep (`[…]` / `{…}` / `(…)` / none) across all six contexts |
| `cases-H` | Verification sweep closing cells the A–G batches left inferred: paren-key / envelope / quoted on a block attribute line, interpolation as a list item, `#` `^` `~` `%` sigils in list, identity-bracket and inline-element contexts |

Harness: `scratch/probe.py` + `core/udon-core/examples/path_probe.rs` (scratch; not a fixture, not committed).

---

*Probe run 2026-07-28 against `v2/current-0.9.1-spec/` and the 0.9.0-alpha.2 reference parser. Nothing here is a ruling; every `[P]` cell pins the current parser, not the language.*
