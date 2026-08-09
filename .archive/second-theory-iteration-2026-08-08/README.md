# paths/ — the udon paths & references design work

**Started 2026-08-06** (session `path-and-reference-work`). This directory is the clean working home for the addressing design: udon references, paths, docstore/logical addressing, and the resolution machinery under all of them. It exists so the work doesn't drown in its sources — **pointers out, not copies in.**

| Here | Role |
|---|---|
| [`OUTLINE.md`](OUTLINE.md) | **The front door** — canon view over `src/`; Part I is the foundational theory, Parts II–III are provisional homes; conventions + register in its preface |
| [`src/`](src/) | The segments (the former theory-and-lexicon, split and drafted; one atom per file) |
| [`terms/`](terms/) | The embedded lexicon — one `.term.un` entry per term (template: verisectorium/template/TERM.term.un; D10), fed by the definition segments; `.archive/` holds the founding `.md` entries |
| [`hypothetical-sketch.md`](hypothetical-sketch.md) | The concrete hypothetical (the `@<…>` reference-act IR, `$DOCUMENT`, DON (the store spec, ex-LUSS), the type-algebra connection) — wet clay, nothing cemented; Part II rows are its homes-in-waiting |
| [`ra-feature-matrix.md`](ra-feature-matrix.md) | The five-column instrument: theory features → usecase → syntax-free RA parts → SQL+alg-types → udon spelling; dependency left→right |
| [`DECISIONS.md`](DECISIONS.md) | Thin present-truth ledger of ratified calls (`decided-by`-marked) · [`CHANGELOG.md`](CHANGELOG.md) is the history layer |
| [`INFLUX/`](INFLUX/) | Drop-box + set-aside material — consultable, not authoritative; `.integrated/` holds dispatched sources |

**The source map** (read at the primary before building on any of it; none of it lives here):

- Steward brainstorms: `../theory/to-integrate/primary/DISCUSSION-THOUGHTS.udon` (O13/O13a path decomposition; O14/O17/O18 decision-authority; O15 expectation arity) · `~/src/arch/firmatum/verisectorium/theory/INFLUX/steward-brainstorms/instance-naming-and-paths-2026-08-06.md` (the URI convergence + pause call)
- Measured mechanics: `../theory/to-integrate/refine-more/paths-ideation/terminator-table.md` (~130 cases; the `]` law; D-a/D-d steward gates)
- Demand map: `../udon-needs/02-tooling-needs/reports/addressing-exploration.md` (D1–D9, traps, the three multiplicities)
- Ideation + survey: `../theory/to-integrate/refine-more/paths-ideation/README.md` + `survey.md` (182 notations; optics/lens laws; Saltzer; Plan 9)
- The logical layer: `../theory/to-integrate/primary/underlying-logical-model.md` §3–5 · `db-theory.md` · `type-algebra.md` (arity algebra; discriminator ladder)
- Shipped resolution prior art: relata's designator/ladder/aliases (`doc-store-and-schemas-report.md` §8) · NORMS.md BASENAME unions (`~/src/arch/notes/NORMS.md`)
- Standing law: `../current-0.9.1-spec/` (the only recognition oracle) · `../DECISIONS.md` (S14, PATH-1, W3, X1–X6) · `../OPEN.md` (REF-SLASH, REF-BRACKET, S3, ML)

**Register discipline** (binds here as everywhere): decided / evidenced / proposed / open, each in its own voice; the current grammar is a fact to price, never the verdict (O14/O17); nothing here closes a carve-out except by earning it.
