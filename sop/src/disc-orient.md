---
slug: disc-orient
form: discussion
status: discussion-grade
max: decided
state: [drafted]
depends: []
---

# ORIENT — how a mind meets this corpus

This is the founding seed of this instance's **SOP store** — copied and adapted from the verisectorium theory instance's ORIENT (2026-08-08), per the rule that instance praxes are *copies with local deltas*, maintained here; verisectorium detects and proposes upgrades when the general SOPs change, through `sop/INFLUX/`. It is one segment now; it atomizes into `sop/src/` siblings as content earns it (`sop/SOP.outline.md` is the view over them).

**Orientation is three things, in order.** Do not substitute fluency for the first one — the ability to imitate this corpus's forms arrives long before knowledge of what it has already settled, and that gap is how earlier editions of this very theory went wrong (see `.archive/`).

## 1. Doctrina — know what the corpus already knows

Read, in this order, *before* substantive work:

1. `CLAUDE.md` (the front door — the layout table and priorities).
2. This file, whole.
3. `LEXICON.md` — generated from `def/`; the vocabulary everything else speaks. While `def/` is young, `defs.source.ud` is the interim carrier (see Praxes below).
4. `ADDRESSING-THEORY.outline.md` whole, Working Notes included — the canon view over `src/`.
5. The `def/` segments, then the `src/` segments the outline marks drafted. Experiential reading is the recommended mode: predict → read → diff → wander.
6. `../udon-0.9.1-primer.md` — the standing rule for all udon work: read it *"for the lay of the land, not as a gate/check on any ideation that might conflict with it."* Without it you will reconstruct "a markup language" from training priors, confidently and wrongly.
7. `PRACTICA.ud` — where work stands now.

**Contextual primaries** (read at the moment of use, whole, never from a synthesis — `ref/` holds the stable pointers):

| Primary (`ref/`) | Read before |
|---|---|
| `discussion-thoughts` (O13–O18a espec.) | any decision an incumbent grammar fact might swing — O14/O17/O18 are the decision-authority spine (demand→grammar, never grammar→demand; the invasive-change window; "the past is material, never judge") |
| `addressing-exploration` (D1–D9) | cases/usecase drafting — usecases come from measured demand, not invention |
| `type-algebra` | anything typing/schema/arity-adjacent; its N6 is also the estate's best specimen of the evidence-channel infection |
| `terminator-table` | any spelling claim — parser behavior is never language behavior (`[L]`/`[P]` register binds) |
| `current-0.9.1-spec/` | anything recognition-adjacent — re-open the actual section at the point of use; the only recognition oracle |
| `esop15` (scope graphs) | resolution-machinery formalization — the closest pre-existing formalization of the central object |

**Hazards, named so nobody re-learns them:** the 0.8-lineage reference parser is never an oracle (known non-conformant); `design/udon-paths.md` at the repo root is stale archaeology (the positional-integer trap); syntheses read before their primaries manufacture confident false frames — where a primary exists, a synthesis is a locator, not a source; and `.archive/` here is *material under claw-back review*, not a library (see Praxes).

## 2. Praxes — how work happens here

- **Truth over completion, always.** This is a living collection — nothing here "ships," and a session's finish-line is a truthful segment drafted, corrected, or strengthened, or an item honestly discharged — never emptied queues or moved files. Honest incompleteness is a complete discharge: honest tier + working notes saying what is open + release to PRACTICA.
- **def/ has primacy.** Terms are defined once, in `def/<def-term-slug>.ud` — udon segments with the full cadence (frontmatter → title → summary → Formal Expression with notation → Epistemic Status → Discussion → Working Notes). `LEXICON.md` is assembled from them by `bin/` tooling and is never edited by hand. Theory segments in `src/` build *around* the def/ terms and never restate a definition — link and gloss in one line. (The prior edition ran parallel "term entries" that mirrored-but-not-really the segments; that split is retired on purpose — one definer, cited everywhere.)
- **`defs.source.ud` is the declared interim.** Until `def/` is populated, term-settling happens in `defs.source.ud` (CHEATSHEET-2 lineage), under a banner saying exactly that; it retires when its content is integrated into `def/` and passes the delete-test.
- **Segment discipline:** one atom per file; slug = filename; form-kind prefixes only (`def-` `post-` `claim-` `form-` `disc-` `obs-` — never trajectory-kinds); the exemplars' cadence (asf `def-observation-function`, vivarium `def-nomos` are the models); statuses conservative — never borrow rigor from source confidence; same-author estate agreement is coherence, not corroboration; state flags are resettable, never ratchets — on edit, reset the checks the edit invalidates.
- **Register discipline:** derived / evidenced / decided / proposed, each in its own voice; a convention honestly stated is a complete answer, never dressed as a derivation; no absolutes ("the deepest", "the one thing") — precision instead; absence claims carry their search.
- **Self-contained, breadcrumb-free canon.** Math, notation, and definitions stand alone in their segments. Very few pointers out; **zero** meta-commentary about how things changed — that is what `CHANGELOG.md`, `DECISIONS.ud`, and git are for. `ref/` exists so the rare legitimate external lean (a paper, a measured table, a spec) has one stable citable home — cite `ref/` entries in Working Notes and References sections, not scattered estate paths.
- **Claw-back protocol for `.archive/`.** Nothing returns from `.archive/` wholesale. Each claw-back is deliberate: named to the steward first (he vets for defects that crept into the organically-spec'ed `.un`/`.ud` formats), delete-tested on arrival (the content lands in its proper new home — def/, src/, ref/, sop/ — never as a transplanted file keeping its old shape), and recorded in `CHANGELOG.md`.
- **File format:** udon files use the `.ud` extension here (transitional convention, this instance). `def/` entries are udon; `bin/` assembles them to markdown. `md-press --check` every touched `.md` before reporting it done; never run md-press on `.ud`/`.un`/`.udon` files (no canonicalizer exists; the damage mode is documented in the theory FORMAT).
- **Where records land:** present truth → `def/` + `src/` + the outline; decisions → `DECISIONS.ud` (append-or-expressly-overturn, `decided-by`-marked); process rules → this store; state → `PRACTICA.ud`; what-happened-and-why → `CHANGELOG.md` — never headers, preambles, or segment bodies. Route the record; don't carve it into the nearest surface.
- **Steward relationship:** Joseph holds the valve. Genuine forks go to him as real briefs (context + options + recommendation + honest uncertainty); his brainstorms are captured verbatim first, organized second; his fiat is marked as fiat. Decision authority flows demand→theory→grammar, never grammar→demand; the current 0.9.1 grammar is a fact to price, never the verdict. Delegation in peer voice — `~/src/arch/AGENTIC-DELEGATION.md` binds here as everywhere.
- **Commits:** one attributable thing per commit, batching plan stated first; this corpus's history is studied by future agents.

## 3. Professio — declare yourself

Before substantive work, having done 1 and 2, write a few sentences — in your session, and if the work is significant, in your first commit message or working note — declaring *in your own words* what you understand the telos to be and which of the praxes above you expect to find hardest to keep under pressure. Voluntary, owned, revisable, scoped to your session; performed as a checkbox it is worthless, and skipping it honestly is better than performing it.

## Feedback channel (this store's influx)

Participant feedback is the only amendment channel for this store. If anything here confused you, fought the reality in front of you, or proved wrong: record it in `sop/INFLUX/`, and if urgent, surface it to the steward. Feedback that concerns the *general* verisectorium conventions (not this instance's content) also gets a copy routed to the verisectorium theory instance's `sop/INFLUX/` — that is its upgrade-detection channel. Front-line confusion is the re-truthification signal, not noise.

*(none yet)*
