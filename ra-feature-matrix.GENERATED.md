# RA feature matrix — GENERATED VIEW

> [!warning] Generated file — do not hand-edit.
>
> Regenerate with `bin/refresh`. The population is [`OUTLINE.md`](OUTLINE.md) (per **D3**: segments and the outline are the authority; this file is a view over them). Anything true here that is not in the outline is a bug in this file or a gap in the outline — fix the outline, never this.
>
> Written from `OUTLINE.md` as of 2026-08-07. The hand-maintained [`ra-feature-matrix.md`](ra-feature-matrix.md) is still present for comparison; the divergence report at the bottom is the diff that matters.

## Aspects × stages (Part III)

*Rows are Part III chapters (the aspects); columns are the stage progression the outline declares for every chapter (theory → cases → RA → SQL → spelling). Each cell carries the outline row's `State`, any `blocked(…)` it names, any `sketch §` it cites, and the row's tag. `—` means **no row exists in the outline for that stage** — proposed-not-missing does not apply to a stage nobody has seeded yet, so an em dash here is a real gap, not a state.*

| # | Aspect (chapter) | Cases | Syntax-free RA | SQL + alg-types | Udon spelling |
|---|---|---|---|---|---|
| 1 | **Designation & Aliases** | proposed<br>[[disc-designation-cases]] | proposed<br>[[form-designation-ra]] | — | proposed · blocked(form-designation-ra) · sketched §5<br>[[form-designation-spelling]] |
| 2 | **Description & Selection** | proposed<br>[[disc-selection-cases]] | proposed<br>[[form-selection-ra]] | — | proposed · blocked(form-selection-ra) · sketched §12.2<br>[[form-selection-spelling]] |
| 3 | **Origins & Perspectives** | proposed<br>[[disc-origin-cases]] | proposed<br>[[form-origin-ra]] | — | proposed · blocked(form-origin-ra) · sketched §12.4<br>[[form-origin-spelling]] |
| 4 | **Sequence & Walk** | proposed<br>[[disc-walk-cases]] | proposed<br>[[form-walk-ra]] | — | proposed · blocked(form-walk-ra, walk-default) · sketched §3<br>[[form-walk-spelling]] |
| 5 | **Arity & Expectation** | proposed<br>[[disc-arity-cases]] | proposed<br>[[form-arity-ra]] | — | proposed · blocked(form-arity-ra) · sketched §4<br>[[form-arity-spelling]] |
| 6 | **Verification, Moments & Value Addressing** | proposed<br>[[disc-verification-cases]] | proposed<br>[[form-verification-ra]] | — | proposed · blocked(form-verification-ra) · sketched §6<br>[[form-verification-spelling]] |
| 7 | **Temporal & Version Dynamics** | proposed<br>[[disc-temporal-cases]] | proposed<br>[[form-temporal-ra]] | — | proposed · blocked(form-temporal-ra)<br>[[form-temporal-spelling]] |
| 8 | **Projection & Rewrite** | proposed<br>[[disc-projection-cases]] | proposed<br>[[form-projection-ra]] | — | proposed · blocked(form-projection-ra) · sketched §12.3<br>[[form-projection-spelling]] |
| 9 | **Boundaries, Stores & Spans** | proposed<br>[[disc-boundary-cases]] | proposed<br>[[form-boundary-ra]] | — | proposed · blocked(form-boundary-ra, region-decl) · sketched §6<br>[[form-boundary-spelling]] |
| 10 | **Outcomes & Dispositions** | proposed<br>[[disc-outcome-cases]] | proposed<br>[[form-outcome-ra]] | — | proposed · blocked(form-outcome-ra) · sketched §2, §12.5<br>[[form-outcome-spelling]] |

## Foundation the aspects stand on

*The theory stage of every aspect is Part I/II canon rather than a per-chapter row, which is why the table above has no theory column. These are the rows that supply it.*

**Part I — Foundation**

| Tag | Type | Max | State |
|---|---|---|---|
| [[intro-postal-model]] | Discussion | discussion-grade | drafted |
| [[def-descriptors]] | Definition | axiomatic | drafted |
| [[def-locations-and-paths]] | Definition | axiomatic | drafted |
| [[def-cardinality-and-resolution]] | Definition | axiomatic | drafted |
| [[def-entities-values-promises]] | Definition | axiomatic | drafted |
| [[disc-fetch-and-overdetermination]] | Discussion | discussion-grade | drafted |
| [[claim-sequence-causes]] | Derived | robust-qualitative | drafted |
| [[obs-address-components]] | Observation | empirical | drafted |

**Part II — Common Capabilities**

| Tag | Type | Max | State |
|---|---|---|---|
| [[form-act-value]] | Formulation | decided | proposed |
| [[form-act-anatomy]] | Formulation | decided | proposed |
| [[claim-acts-as-operands]] | Hypothesis | robust-qualitative | proposed |
| [[form-resolve-moments]] | Formulation | decided | proposed |
| [[form-luss]] | Formulation | decided | proposed |
| [[claim-type-algebra-correspondence]] | Hypothesis | robust-qualitative | proposed |

**Part IV — Evidence & Formal Grounding**

| Tag | Type | Max | State |
|---|---|---|---|
| [[claim-scope-graph-grounding]] | Claim | robust-qualitative | proposed |
| [[claim-carry-perspective]] | Claim | robust-qualitative | proposed |
| [[claim-pipeline-determinacy]] | Claim | robust-qualitative | proposed |
| [[claim-route-as-semiring]] | Claim | robust-qualitative | proposed |
| [[claim-binder-cliff]] | Claim | robust-qualitative | proposed |
| [[form-anchoring-ladder]] | Formulation | decided | proposed |

## Divergence report — outline vs the hand-maintained matrix

*Mechanical findings only; each is a question for the steward, not a verdict. Per D3 the repair for every one of these is an **outline** edit (or an accepted loss), never an edit to the hand matrix.*

### Chapters with no matrix rows at all (column-1 closure gaps)

- **Temporal & Version Dynamics** — the hand matrix has nothing for this aspect

### Matrix rows no chapter claims (population says they have no home)

- row 3 — *Mixed conjunction* (“The decision keyed x, in the vivarium ledger”)

### Stages with no outline row

- SQL + alg-types: 10 of 10 chapters have no row

### Substance that lives only in the hand matrix (a generated view would lose it)

- **Per-feature decomposition.** The hand matrix carries 34 numbered theory features; the outline carries 10 chapters. The feature→chapter grouping exists *only* in the chapter headers' transitional row cites; the feature list itself has no home in the outline.
- **Example usecases (column 2).** 34 plain-English usecase strings live only in the matrix. The outline's `disc-*-cases` claims summarize case *families*, not the individual worked cases.
- **Syntax-free RA slot expressions (column 3).** 34 rows carry concrete slot notation (`des:[…] ar:{n,m}` …) that appears nowhere in the outline. This is real content, filled at the RA stage — it wants a home in the `form-*-ra` segments when they draft.
- **The slot-notation legend and the column-4 SQL plan** (matrix preamble + working notes) are design decisions, not tracking; they belong in a segment or in DECISIONS, not in a regenerable view.
- **The column-1 closure-check candidates** (join-by-shared-value / write-back contracts / cross-act constraint) in the matrix working notes are open findings with no outline row.

*Generated by [`bin/refresh`](bin/refresh) from `OUTLINE.md` (34 hand-matrix rows read for the divergence report only).*
