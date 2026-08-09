# ORIENT — how a mind meets this corpus

This instance's praxes are a **projection of the verisectorium theory's** ( [[form-canon-praxes-projection]]): read `~/src/arch/firmatum/verisectorium/theory/sop/ORIENT.md` first — its doctrina/praxes/professio structure governs here whole. This file carries only the **local deltas**:

- **Doctrina order for this corpus:** README → this file → `OUTLINE.md` whole (Working Notes included — the authority ruling, organization decision, and coherence review live there) → Part I segments in outline order ( [[intro-postal-model]] first, always) → the matrix and sketch as instruments/sources, per **Current instruments** below. `INFLUX/problem-statement-outline.md` is set aside — do not draft from it (steward call; superseded and biasing).
- **The process law unique to this instance:** stage-rows draft left-to-right within each Part III chapter — theory → cases → RA → SQL → spelling (the matrix's left→right dependency as each chapter's internal arc; the matrix doubles as the aspects×stages tracking view, generated-pending-tooling). Each chapter seeds three rows: `disc-<aspect>-cases` (usecases, plain English), `form-<aspect>-ra` (theoretical RA parts, syntax-free), `form-<aspect>-spelling` (SQL-lab + udon-RA, blocked on the RA row). A spelling drafted before its RA row is the violation to watch for; the current grammar is a fact to price, never the verdict (O14/O17).
- **Part shapes:** Part I = intro on-ramp first (always), then grouped formal definition segments (each closing with its "Terms defined here" declaration into `terms/`), then discussion/claim segments; Part II = cross-cutting machinery, populated by **demand-driven promotion only** (a thing moves there when it proves cross-cutting — never pre-fabricated); Part III chapters are provisional carves that may re-group as RA drafting teaches.
- **Where things land:** present truth → segments/outline; **decisions → `DECISIONS.md`** (thin ledger, `decided-by`-marked, append-or-overturn); process rules → this file; what-happened-and-why → `CHANGELOG.md` (newest first) — never headers, preambles, or segment bodies (the breadcrumb law: route the record, don't carve it into the nearest surface).
- **Authority:** segments > outline > matrix (generated view, pending tooling) > sketch (wet clay); `DECISIONS.md` is the ledger of ratified calls — cite decisions by slugged link (`[[DECISIONS#d11-universal-path|D11 universal-path]]`-style), so every citation names what it cites and resolves without prior knowledge of the ledger. The `[recall]` items in the formalisms survey are unverified until checked — do not cite them externally.
- **Terms co-evolve with canon:** a segment introducing or revising a term owns updating its `terms/` `.term.un` entry in the same touch (format of record per D10; template at `verisectorium/template/TERM.term.un`).
- **Conventions (from the verisectorium theory's exemplars, local to this corpus):** `State` describes (`proposed` until a draft exists in `src/`, `drafted` after; checks are resettable flags, not ratchets); `Expected Type` is a prediction drafting may overturn; `Max` is the ceiling, assignable from claim-kind; slugs carry form-kind prefixes only (`def-` `claim-` `form-` `disc-` `obs-` `intro-`); `[[wikilinks]]`; frontmatter schema provisional pending the verisectorium epistemology decision (stated here once, not per-segment); one-logical-line paragraphs, `md-press --check` before reporting any `.md` done.
- **Register:** Part I is drafted but not yet steward-verified row by row. Parts II–III rows are provisional homes over wet-clay or unverified sources — nothing there is settled by having a row. Terms entries' definition halves are generated-pending-tooling projections of segment definition spans (unification design in the outline WN); their naming-metadata halves are native.
- **Current instruments and sources, and how to treat each:**
  - **[`ra-feature-matrix.md`](ra-feature-matrix.md)** — **the primary source for the formalization segments and the instance's tracking instrument**: rows×columns = aspects×stages, so its marks (`—`/`sketched`/`blocked`) are Part III's state vocabulary; its left→right dependency is each chapter's internal arc; its column-1 closure check is the standing completeness probe for the aspect carve. **This will need to be *generated from the outline* rather than its current position as informing the outline.**
  - **[`hypothetical-sketch.md`](hypothetical-sketch.md)** — stays live (wet clay); its cross-cutting pieces are Part II's homes-in-waiting, its aspect-specific pieces feed Part III's *spelling-stage* rows (arriving last per aspect, where the left→right dependency puts spellings); not dispatched until its texture lands in drafted segments (delete-test).
  - **[`INFLUX/`](INFLUX/)** — evidence and set-aside material; the formalisms survey feeds Part III; `problem-statement-outline.md` is set aside as superseded by Part I (steward call, 2026-08-07 — biasing content, do not draft from it).
  
  ---

## Reading list — what to read, when, and why

*Curated 2026-08-07 by the founding coord from a full first-hand pass over essentially everything below (the whole spec suite, the theory corpus, the demand reports, the ideation seeds, and the primaries under them) — so the when/why judgments are lived, not inferred from titles. One agent's first pass; revise freely as your own reading teaches differently. The principle it exists to serve: read the right primary at the right moment instead of copying everything into INFLUX — and never draft from a synthesis when its primary is one Read away.*

### Always — before proceeding at all

| Source | Why |
|---|---|
| `../../udon-0.9.1-primer.md` | Joseph's standing rule for all udon work: read it **"for the lay of the land, not as a gate/check on any ideation that might conflict with it."** Without it you will reconstruct "a markup language" from training priors, confidently and wrongly. ~240 lines. |
| This corpus's doctrina order (above) | README → this file → OUTLINE whole → Part I segments in order. |

### Critical frame — before any substantive design work here

These four built the frame this corpus depends on; working without them produces plausible-but-unprincipled output that *reads* fine and re-litigates settled ground.

| Source | Why / when |
|---|---|
| `../../theory/to-integrate/primary/DISCUSSION-THOUGHTS.udon` | The steward-brainstorm primaries. **O14/O17/O18/O18a** are the decision-authority spine (demand→grammar, never grammar→demand; the invasive-change window; "the past is material, never judge") — the single most-reproduced failure in this territory is an incumbent grammar fact silently swinging a design, and these are the antidote. **O13/O13a** (perspective decomposition; match-vs-walk) and **O15** (expectation arity) are direct ancestors of Part I. Read whole; the per-thought register discipline is itself a model of how to hold pre-validation steward material. |
| `../../theory/to-integrate/refine-more/paths-ideation/terminator-table.md` | The measured mechanics (~130 cases): what spellings are actually free vs costly, the one real collision (`]`, two contexts), the two steward gates (D-a `/`-in-references, D-d selector-bracket). Read before any spelling-stage row, and before believing any claim of the form "X can't be spelled." Its `[L]`/`[P]` register discipline is binding: parser behavior is never language behavior. |
| `../../udon-needs/02-tooling-needs/reports/addressing-exploration.md` | The demand map (D1–D9 with confidences; the three multiplicities; the traps list). Read before cases/RA drafting so usecases come from measured demand rather than invention. **Trap 1 is live**: `design/udon-paths.md` is the stale document whose positional-integer rule is the sharpest known trap — archaeology only, never law. |
| `../../theory/to-integrate/primary/type-algebra.md` | The τ algebra Part II's correspondence row rests on (rows, hedges, arities, the three fiat seats, N1–N3 fences). Read before projection/census/schema-adjacent work. Its N6 + Working Notes are also the estate's best specimen of the evidence-channel infection (a crisp measurement lending authority to an incumbent frame) — read the correction, not just the result. |

### Contextual — read before decisions touching the named area

| Source | Read when / because |
|---|---|
| `../../theory/to-integrate/primary/underlying-logical-model.md` | Before `$DOCUMENT`/file-role/store decisions (§5 roles, §7 includes). *Register caution: a conversation record, provisional throughout, parts already corrected by later passes — its own §8 lists what it doesn't know.* |
| `../../theory/to-integrate/primary/db-theory.md` | Before DON(store)/pipeline/temporal decisions (movement I set-theoretic roles; movement II time-as-fold-over-git; the starter layouts). Dialogue record, one mind; its own header names the standing pressures against it (minefield §3.10/§3.13). |
| `~/src/arch/notes/NORMS.md` | Before store/BASENAME/layout decisions — the raw demand the "NORMS reduces to DON" hypothesis (ex-LUSS) is about. Register: steward scratch, pre-validation, self-flagged open questions. |
| `../../theory/to-integrate/refine-more/doc-store-and-schemas-report.md` | Targeted sections only (it is 3.5k lines): **§8** designator/ladder/aliases before resolution-protocol work (the deepest shipped prior art); **§12.4** the cluster record before region/span work; **§17** the evidence model before confidence/outcome design; **§1.5** three scales of supersession as method. |
| `../../theory/to-integrate/refine-more/paths-ideation/survey.md` | Before claiming novelty or importing a formalism — 182 notations + family W theory; overlap-check against `INFLUX/formalisms-survey-2026-08-07.md`, which deliberately avoids re-tilling it. |
| `INFLUX/formalisms-survey-2026-08-07.md` | Before Part IV drafting. Its `[recall]` items are unverified by its own banner — verify before external citation; the two `[verified]` anchors (scope graphs, Phelps–Wilensky) are citable now. |
| `~/src/arch/firmatum/verisectorium/theory/INFLUX/steward-brainstorms/instance-naming-and-paths-2026-08-06.md` | Before origin/instance-addressing decisions — the demand event that ripened this whole design ("this is becoming very URI-ish… time to nail down udon paths"). |
| `../../current-0.9.1-spec/CORE.md` (+ suite) | Whenever touching anything recognition-adjacent: re-open the actual section at the point of use (the repo's standing law — memory of an earlier read is not the source). Load-bearing five: §2.1, §2.2, §6.4, §6.5, §14.1. |
| `../../theory/to-integrate/refine-more/living-documents/README.md` | Before include/disposition work — §1b (the ascribed typed-graft include) and the power-envelope steward statement ("without turning into rebol") live there. |
| `../../theory/to-integrate/primary/format-failures/MINEFIELD-MAP.md` | Before schema-layer or ship-a-resolver decisions — M13 (grammar+assertions), M9 (inert references freeze; ship one resolver early), §3.10 (the second-store tension). *Joseph's caveat attaches: "lots of assertions not necessarily validated as strongly as they sound" — its own register marks say which.* |
| `../../theory/to-integrate/refine-more/paths-ideation/README.md` | Archaeology of the pre-foundation ideation (families A–E, speech acts, the anchors menu). Superseded in frame by Part I; still the richest inventory of considered-and-parked options. Read knowing its globs lean was retracted (O14) and its family taxonomy predates the act anatomy. |

### Set aside / hazards — named so nobody re-learns them

- `INFLUX/.archive/problem-statement-outline.md` — **do not draft from** (steward call: superseded and biasing; a corpus-synthesis arranged as an arc, the confabulation shape).
- `design/udon-paths.md` (repo root design/) — stale; the positional-integer trap; archaeology only.
- The old spec route (`spec/CORE.md`, 0.9.0-alpha.2) — record/oracle for the parser era only; **cite 0.9.1 exclusively** here.
- The 0.8-lineage reference parser — never an oracle for anything in this corpus (known non-conformant); parser facts are `[P]`, pinned, never language claims.
- General hazard, lived twice in this corpus's own founding: **syntheses read before their primaries manufacture confident but false frames** — where a primary exists and is load-bearing, the synthesis is a locator, not a source.

---
- **Feedback on the verisectorium conventions themselves** (not this corpus's content) routes to the theory instance's SOP influx — front-line confusion is the re-truthification signal, not noise.
