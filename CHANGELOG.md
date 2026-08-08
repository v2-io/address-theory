# CHANGELOG — history layer (newest first)

*Present truth lives in segments and the outline; process rules in `sop/ORIENT.md`; this file is where what-happened-and-why lands, so it stops carving itself into headers and preambles.*

## 2026-08-08 — terms instantiated as .term.un (fork; staged, dual-format)

- A context-fork read the verisectorium terminology survey whole, founded `verisectorium/template/TERM.term.un` (universal; WHY-argued choices; set-rel/formal fields for Euler-derivability and algebraic definitions), derived the narrow local subset `terms/TERM.term.un`, and instantiated all 26 entries as `terms/<term>.term.un` beside their `.md` originals — replace-vs-ride is Joseph's call, both kept. Template feedback (incl. three hallway-test findings) routed to the theory instance's SOP influx. Known gap: `bin/refresh-lexicon` doesn't read `.term.un` yet — converge checker and format.

## 2026-08-08 — location re-carved (D12); typespec sketch cut; vocabulary tightening

- **D12**: location = containment description built from a container designator (`location ⊂ description`, `containment-coordinate ⊂ designator` — the partition holds without a third arm); standalone location = scope; path positions are roles. Companion theorem landed in canon: descriptor-kind is per-act; all chains bottom out in designators. def-locations-and-paths carries both.
- **Typespec sketch** (`INFLUX/typespec-sketch-2026-08-08.un`): first cut of the tier-3 formal layer — Part I's terms as sorted set/type definitions with arities and invariants, wet clay, the seat the coherency checker's semantic tier would verify against.
- Proposed to steward, not landed: promise-table re-terming (canonical/preferred as *path*-promises per the D11 knock-on); `scope` mint.

## 2026-08-08 — universal location re-carved as UNIVERSAL PATH (D11)

- Steward correction out of the ERD review dialogue: "universal location" was the theory's own vocabulary committing the path/location conflation its segment diagnoses — the concept is a **universal path** (path with universal origin; syn. absolute path). Canon updated (def-locations-and-paths definition + reduction theorem + discussion; claim-sequence-causes special-case cite; obs-address-components), the origin trichotomy (explicit | implicit | universal) recorded as body-absorption candidate, `origin`/`destination` mints ratified, and the promises-table knock-on (canonical/preferred as *path*-promises?) flagged in def-entities WN for adjudication. Terminology-side rename (designation-status flip, the template's hidden-label machinery's first live use) delegated to the fork.

## 2026-08-08 — terms move to .term.un (D10); diagram tooling lands

- The 26 `.md` term entries archived to `terms/.archive/` and replaced by `.term.un` instantiations of the new `verisectorium/template/TERM.term.un` (founded same session from the terminology survey; steward: "replace the .md terms completely"). `bin/refresh-lexicon` patched to read `.term.un` as the format of record (26 entries, 36 located findings — the honest drift state carries over). New `bin/terminology-diagrams` derives `terms/diagrams/{euler.dot,relations.dot,relations.mmd}` from the `|set-rel`/`|rel` graph — Euler containment from subset-of/partitions only (part-of stays mereology), overlaps as annotated edges, duals bolded; validated through graphviz. Template feedback (partition-wants-parent; part-of ≠ subset-of; phase-law linting) routed to the verisectorium theory SOP influx. These changes committed same-day at steward direction; the wider session batch remains staged for review.

## 2026-08-08 — steward's bottom-line pipeline notes captured

- Joseph's handwritten "pretend you're implementing it right now" notebook pages (the sketch that informed DON, previously shown only to the prior agent) transcribed + read into `INFLUX/steward-notes-bottom-line-pipeline-2026-08-08.md` (photo is primary; transcription is frozen baseline, coord reading beside it). Theory touches: the **write-back trilemma** (pipeline-backwards / project-en-whole / store-is-canon — read as a canonicity election) added to disc-store-cases; **cooked/uncooked** candidate vocabulary + schema-as-bind-moment-input + the self-hosting bootstrap note recorded in disc-store-composition-model WN. The sketch's own margin answers its schema question (four pipeline jobs assigned to schema), and its "Pipeline decision to make!" independently confirms per-seat/per-pipeline resolution moments.

## 2026-08-08 — LUSS renamed DON (D9)

- The store spec renamed **DON** (donburi, the serving bowl) from LUSS, steward selection among coord candidates (kamado, yude, plain udon-store also offered; kama/nabe pre-eliminated for slang baggage). Slug `form-luss` → `form-don`; present-truth surfaces updated (OUTLINE, README, sop/ORIENT, two segments, D7's text); history layers (this file's earlier entries, INFLUX gathered notes) keep LUSS verbatim per the rename discipline.

## 2026-08-08 — store-composition theory segment drafted (steward-invited scaffold)

- **Store Composition aspect chapter founded** (steward ratification, same exchange): the new segment moved from Part II to be its theory row; disc-store-cases / form-store-ra / form-store-spelling seeded proposed-not-missing; demarcation vs Boundaries stated in the chapter gloss (Boundaries owns crossing/unioning from the act's view; this chapter owns what a store is); form-luss stays cross-cutting in Part II. Matrix rows: none — second live closure gap after Temporal.
- [[disc-store-composition-model]] drafted into Part II at steward invitation — the tentative store vocabulary (store/seat/mechanism, contract line, role-behavior open/closed split, bind moment, store-as-perspective-engine, mint-once, per-seat moments, honest non-atomicity), generalized from the first-hand rowan reads (three passes: docs, then two steward-directed test batches, all in `INFLUX/rowan-composition-first-hand-2026-08-08.md`). Register: coord-drafted, single-source generalization, falsifier sweep named in its WN as the next stage; terms/ entries deliberately deferred until a steward pass. Analogue of the initial steward pass that became Part I, one authority rung lower.

## 2026-08-08 — steward store map lands; explorer harvest corrected

- Joseph delivered the authoritative rowan store-types + multi-store map (repo-side); landed verbatim at `INFLUX/rowan-store-map-steward-2026-08-08.md`. It corrects the explorer harvest on two load-bearing points (MultiStore deleted-not-in-progress; the aspirational store plurality exists — Redis/ES/field-level-routing/simulation scenarios) — corrections banner added to the explorer file rather than silent edit. New LUSS-relevant pointers the explorer missed: open-questions §Multi-Store, ISSUES' target-store queries + field-level routing (a perspective-selection and a projection/disposition demand respectively), batch.rb, schema/operations.rb, and the 2025-12-18 consciousness-infra reflections.

## 2026-08-08 — rowan store-concepts harvest (explorer to source) + operata copy

- Steward-directed explorer read `~/src/rowan` at source (pin `0ecf61a`); report landed verbatim at `INFLUX/rowan-store-concepts-harvest-2026-08-08.md`. Honest headline: the store-*composition* intuition is deep and argued (ADR-001), but the remembered "flat directories, etc." plurality isn't there — one flat non-recursive directory adapter; LUSS's layout ladder extends rather than ports. `archema-operata.udon` copied to `INFLUX/archema-operata.copy.udon` (steward vote, provenance frontmatter intact) so the RA cases quarry doesn't get forgotten.

## 2026-08-08 — rowan/archema harvest (steward-directed full read)

- Sixteen documents from the udon-needs provenanced gather (archema + rowan schema clusters) read whole by the session coord; synthesis landed at `INFLUX/rowan-archema-harvest-2026-08-08.md` with a residual section serving as the ingestion marker (sources live in `udon-needs/`, not moved). Theory touches: designation cases gained collision-by-merge and decision-events; temporal cases gained upcast-on-read and the evolution ladder; form-luss gained shipped prior art; claim-sequence-causes WN gained a live cause-3 specimen and the perspective-shift fourth-cause candidate from the 2026-08-07 session.

## 2026-08-07 — wikilink reclassification (D8); re-satisfaction skepticism flagged (evening session)

- **The wikilink straw-man corrected** (D8, `supported`): the split had carried an agent-synthesis characterization of wikilinks as "descriptions wearing designators' clothes" into three segments; steward pushback inverted it — the stem is the entity's natural-key designator, collision is the loud/mint-time failure, and description-like behavior is only the unpoliced degenerate case. Salvaged general rule now in [[def-descriptors]]: descriptor kind is determined by the binding's maintenance, not the spelling. Surfaced by use (an agent built on the false example; one steward question broke the chain), not by comb — first live instance of the split's isolate-and-fix purpose.
- **Steward skepticism on "silent re-satisfaction" recorded** ([[def-descriptors]] WN): possibly cruft on a state-based foundation that event-sourcing dissolves; adjudication deferred to temporal dynamics.
- **Conventions lesson routed to verisectorium SOP influx** (pending): illustrative examples inside definition segments inherit segment-level authority without claim-level verification — the channel this falsehood rode in on.
- **Temporal & Version Dynamics chapter seeded in Part III** (steward request, same evening): three proposed rows after Verification; owns as-of/version/upsert theory over an event-sourced substrate and the deferred re-satisfaction adjudication. Matrix has no corresponding rows — recorded in outline WN as a closure-check gap, not patched into the matrix (D3).

## 2026-08-07 — engine obligations adopted; DECISIONS ledger founded; reading list (founding coord, later same day)

- **DECISIONS.md founded** with the seven-value `decided-by` vocabulary (steward proposal, a variation of vivarium's convention) and seeded with the founding decisions D1–D5 (previously living only in outline WN / ORIENT) plus the two new calls below.
- **Engine obligations five and six adopted** (D6 found-but-weakly, D7 zero-only-from-completed-perspective — both `ratified`): landed in [[def-cardinality-and-resolution]]'s body, typed-outcome list extended, WN candidates deleted per integration-is-replacement (one genuinely-open remainder kept: attestation mechanics per perspective kind). Trigger: the founding coord's "adopt or decline, don't let them drift."
- **ORIENT gained the tiered reading list** (Always / Critical frame / Contextual / Set-aside+hazards), curated from the coord's full first-hand pass; each entry carries the failure-that-occurs-without-the-read rather than a bare recommendation. Deliberate omissions recorded in-session: the methodology corpus (praxes-level, carried by verisectorium), late-misc-synopsis (synthesis-before-primary hazard; its load-bearing content has better homes).

## 2026-08-07 — founding session (outside coord + steward)

- **Meta sweep:** convention/register/shape prose moved out of the OUTLINE preface and chapter preambles into `sop/ORIENT.md` (the Current Instruments section too); outline preambles reduced to reader-facing glosses. Trigger: steward observation that the scattered meta was the record-instinct with no home — this CHANGELOG founded as the fix, and the history-layer gap reported back to the verisectorium template.
- **Authority ruling:** the ra-feature-matrix is a generated view (segments/outline are the population); its row-number cites in chapter headers are transitional mapping until a generator exists.
- **Reorganization (same day as laid):** the sketch-shaped Part II was replaced by Common Capabilities (demand-promotion only) + Aspects (nine chapters, per-aspect theory→cases→RA→SQL→spelling progression; axis chosen over parts-by-pipeline-stage, which would have made process the spine). Sketch content redistributed: cross-cutting → Part II, aspect-specific → spelling-stage rows.
- **Founding:** OUTLINE + 8 Part I segments split near-verbatim from theory-and-lexicon.md (→ `INFLUX/.integrated/`, delete-test passed; coherence review in outline WN); `terms/` seeded (26 entries; unification design in outline WN); `sop/ORIENT.md` founded as a projection of the verisectorium theory's ORIENT with local deltas; `INFLUX/problem-statement-outline.md` set aside as superseded (steward call). Conventions inherited from the verisectorium theory instance.
