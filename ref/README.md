# ref/ — citable primaries

The stable home for external material segments may cite (Working Notes and References sections). Everything here is a primary or a measured instrument — never a synthesis. Read whole at the moment of use; ORIENT.md's contextual-primaries table says when each is load-bearing.

Since this instance became its own repository (2026-10-09), every entry is a copy: the udon-side primaries that were symlinks are byte-identical copies of their sources as of the move, recorded in *Provenance* below. When a source moves on in udon, the copy here does not follow it; re-copy deliberately, and note it in CHANGELOG.md.

| Entry | What it is |
|---|---|
| *(not copied)* the ruled 0.9.1 suite | The ruled 0.9.1 suite — the recognition oracle for 0.9.1-era claims. It lives in udon at `v2/spec-0.09.01/` (local: `~/src/arch/firmatum/udon/v2/spec-0.09.01/`; as of the move: <https://github.com/v2-io/udon/tree/4dd3609/v2/spec-0.09.01>). udon's current work has moved past 0.9.1 (0.10.x, spec-lite); ask which spec is live before leaning on this one. |
| `udon-0.9.1-primer.md` | The comparative-reader distillation; lay-of-the-land, never a gate |
| `discussion-thoughts.udon` | Steward brainstorms O1–O19a, per-thought register; O13–O18a are the decision-authority spine |
| `addressing-exploration.md` | The demand map (D1–D9, traps, terminator itch) |
| `type-algebra.md` | The τ algebra spike (rows/hedges, arities, three fiat seats, N1–N6) |
| `terminator-table.md` | ~130 measured spelling cases; `[L]`/`[P]` register |
| `esop15/` | Néron, Tolmach, Visser & Wachsmuth, "A Theory of Name Resolution", ESOP 2015 (md conversion + pdf; copy — source archived) |
| `zwaan-2024-defining/` | Zwaan & Bach Poulsen, "Defining Name Accessibility using Scope Graphs", ECOOP 2024 — accessibility as policy over ⟨origin, path, declaration⟩; §3 = best compact statement of the modern query formulation |
| `vanantwerpen-2018-scopes/` | van Antwerpen, Bach Poulsen, Rouvoet & Visser, "Scopes as Types", OOPSLA 2018 — generalized metatheory the `[SG]` proof-inheritance marks point at |
| `rouvoet-2020-knowing/` | Rouvoet, van Antwerpen, Bach Poulsen, Krebbers & Visser, "Knowing When to Ask", OOPSLA 2020 — sound scheduling of queries against a graph still being built; where the seen-imports discipline lives now (bears on MEDIATED-STEP) |
| `zwaan-2023-scope/` | Zwaan & van Antwerpen, "Scope Graphs: The Story so Far", EVCS 2023 — the lineage survey; §5 is the field's candid defect list (import-erasure cost, label-order insufficiency, expressiveness limits) |

## Provenance

Copied from the udon repository (`v2-io/udon`) on 2026-10-09, when this instance moved out of udon's `v2/references/`. Each was a symlink there; each copy is byte-identical to its source at udon commit `4fbe741` (the source files are the same at `origin/main` `4dd3609`).

| Entry here | Source in udon | Last changed there |
|---|---|---|
| `addressing-exploration.md` | `v2/udon-needs/02-tooling-needs/reports/addressing-exploration.md` | `e3044a8` |
| `discussion-thoughts.udon` | `v2/theory/to-integrate/primary/DISCUSSION-THOUGHTS.udon` | `579ac29` |
| `terminator-table.md` | `v2/theory/to-integrate/refine-more/paths-ideation/terminator-table.md` | `579ac29` |
| `type-algebra.md` | `v2/theory/to-integrate/primary/type-algebra.md` | `579ac29` |
| `udon-0.9.1-primer.md` | `v2/spec-0.09.01/udon-0.9.1-primer.md` | `7ccf47e` |

The paper directories (`esop15/`, `vanantwerpen-2018-scopes/`, `rouvoet-2020-knowing/`, `zwaan-2023-scope/`, `zwaan-2024-defining/`) were already copies in udon, and came here with their history.
