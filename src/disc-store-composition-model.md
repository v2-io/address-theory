---
slug: disc-store-composition-model
form: discussion
type-expected: discussion
status: discussion-grade
max: axiomatic
state: [drafted]
depends: [def-descriptors, def-locations-and-paths, def-cardinality-and-resolution, def-entities-values-promises]
---

# Discussion: The Store, Tentatively Defined

A store is not a place; it is a named composition of seats over interchangeable mechanisms — and once that is said precisely, most of what a store must do falls out of Part I's definitions rather than needing new machinery.

## Tentative Formal Expression

*Everything here is held lightly — a first vocabulary pass in the spirit of the one that became Part I, drafted by the coord from first-hand study of the estate's shipped prior art (rowan) and offered for steward correction. Terms are CANDIDATES; none has a `terms/` entry yet.*

*[Candidate (store)]* A **STORE** is a named, ordered composition of **SEATS**. Always a composition — a single file, a single directory, a single database is the one-seat degenerate case, not a different kind of thing. The name is a designator minted in a **store registry** (a naming community with mint-time collision policing, per [[def-descriptors]] and [[DECISIONS#d8-wikilink-designators|D8 wikilink-designators]]); consumers reference stores by name, never by construction.

*[Candidate (seat; mechanism; the seat/mechanism axis)]* A **SEAT** is a claim in the store's routing structure: *(role, direction, mechanism-designator, params, resolver)*. A **MECHANISM** is whatever actually moves bytes — a directory of files, a database, an append-only log, a remote service — identified by designator and shared across every seat that names it. Seat-identity and mechanism-identity are **different axes**: two seats (a read seat and a write seat) may share one mechanism; one role may split across mechanisms. Conflating the two axes is a recurring source of paradox — an argument about "one store or two" usually dissolves into one seat-fact and one mechanism-fact that were never in tension.

*[Candidate (the contract line)]* The **CONTRACT LINE** is the small store-independent promise a mechanism must make (create/read/update/destroy over the model, answering the query interface), above which *all* semantics live and below which everything is the mechanism's private business — layout, granularity, encoding, locking. The line is what makes the mechanism set **open by construction**: a new mechanism cannot perturb any existing composition, because nothing above the line can see what changed. This is the same additivity defense the format built at the type layer (frozen bare set + envelopes), rebuilt at the storage layer — and it is why "which mechanisms exist" is never the interesting question about a store design.

*[Candidate (role; behavior; disposition fan-out)]* A seat's **ROLE** names its purpose; role names are an **open set**. A seat's **BEHAVIOR** is its routing semantics — write-here-first, append-events, fan-out-derived, consult-as-cache — drawn from a **closed menu**, defaulted from the role's name, overridable, validated. The open/closed line runs between naming and semantics. Under multi-seat writes, behaviors make the fan-out a **per-role disposition of one act**: the primary receives the record, an event seat receives a semantic delta, a projection receives a derived view, a cache receives an invalidation. Not replication — one act, projected into each seat's idiom.

*[Candidate (the bind moment)]* A composition is **built free and bound checked**: constructing one never fails, and its obligations (e.g. *some seat must carry the write-primary behavior*) are enforced only at the moment it is **bound to a consumer** — and they are checked *behaviorally*, never nominally. Recognition-total, judgment-layered, at the store layer. Binding is also where a composition's derivation is legible: composition merges are **typed rebinding events with recorded provenance** (which declaration contributed each seat), so a resolved store can report how it came to be.

*[Derived (store as perspective-engine)]* A bound store composition **is** a RESOLUTION ENGINE relative to a PERSPECTIVE ( [[def-cardinality-and-resolution]]) — not configuration an engine reads, but the composed thing that resolves. Its seats are the perspective's membership; its behaviors are the routing; its resolvers are the per-hop ownership of [[def-locations-and-paths]]'s progressive routing. Dynamism is fenced menu-vs-knob-shaped: an act may *select among* declared compositions (the resolver seat), but nothing mutates a composition mid-resolution.

*[Derived (mint-once)]* Identity is minted **once, at the act, upstream of any fan-out**; every seat is *told* the designator and never derives its own. Corollary: co-reference across seats holds by construction, which is the precondition for over-determination verification ( [[disc-fetch-and-overdetermination]], [[DECISIONS#d6-found-but-weakly|D6 found-but-weakly]]) across stores being possible at all.

*[Candidate (per-seat moments)]* A change declared once — a schema evolution, a supersession — applies at **different moments per seat kind**: materialized ahead of reads for mechanisms that require transformation, translated at read for mechanisms that keep old bytes as-is, not at all for the ephemeral. The store layer is the **decider of moments**; truth is seat-invariant while application schedules differ. (This is [[form-resolve-moments]]'s live/once/materialized menu appearing as a *per-seat property* rather than a global election.)

*[Candidate (honest non-atomicity)]* Writes across heterogeneous seats are **not atomic, by admission rather than accident** — no shared transaction boundary exists, and pretending otherwise is the failure mode. The honest structure: transactionality is *introspectable* per mechanism (a consumer demanding atomicity can detect it isn't getting it); loudness-of-failure is a per-composition election; and the recovery story is an event seat as truth plus idempotent rebuild of derived seats — never rollback.

## Epistemic Status

Discussion-grade throughout; every candidate is a *generalization from one shipped system* (rowan's store composition — ADR-001, the composition/behavior machinery, and its behavioral/property test suites, all read first-hand; `INFLUX/rowan-composition-first-hand-2026-08-08.md` carries the per-claim grounding). One system generalizes nothing by itself — max `axiomatic` is reachable only if the candidates survive being pressed against the other store realities in scope (NORMS's demands, the verisectorium store triplet, git-as-store, the udon-needs store scenarios). The two `[Derived]` entries lean on Part I definitions and are the most defensible; `per-seat moments` and `honest non-atomicity` are the most rowan-shaped and should be pressed hardest.

## Discussion

What this vocabulary buys the program, if it holds: **DON's deliverable (the udon store spec, ex-LUSS) becomes crisply statable** — the composition algebra, the behavior menu, and the contract line, with layout (directories, file granularity, one-file-many-records vs file-per-record) explicitly *below* the line as mechanism-private facts. The layout ladder the sketch imagines is then not a ladder of store kinds but a catalog of mechanisms, each priced against the contract — and arguments about layout stop being arguments about the store model. The aspect chapters consume this directly: Origins gets "a bound composition is the engine"; Outcomes gets the behavior menu as its `disp:` substrate; Verification gets mint-once as co-reference's ground; the Temporal chapter gets per-seat moments. The reconciliation with keep-everything is worth one sentence: composition merge *overrides by seat key*, which looks like last-wins — but every override is a recorded rebinding event with provenance, so it is stacking's discipline (nothing silently destroyed) achieved by a different mechanism (evented replacement rather than accumulation).

## Working Notes

- Drafted 2026-08-08 by the session coord at steward invitation ("would that give us solid scaffold?"), register `supported` at best — steward correction expected and wanted, per the Part I precedent ([[DECISIONS#d8-wikilink-designators|D8 wikilink-designators]] caught a straw-man in *steward-derived* text; this segment is one further remove from the source of truth and should be combed harder).
- `terms/` entries deliberately not created for the candidate terms — premature until the steward pass settles which survive (interim exception to the terms-co-evolve convention, noted here per ORIENT).
- Single-source hazard, named: every candidate generalizes rowan. The falsifier sweep is the segment's next stage — press each candidate against NORMS, the verisectorium triplet, git-as-store, and the udon-needs scenarios; candidates that only describe rowan get demoted to specimen facts in the INFLUX note.
- Relationship to [[form-don]]: this segment is the *theory* stage of the store territory; form-don remains the cross-cutting *formulation* in Part II.
- Candidate vocabulary from the steward's bottom-line sketch (INFLUX steward-notes-bottom-line-pipeline-2026-08-08): **cooked/uncooked** as the axis the pipeline traverses (source chunks uncooked → cooked logical udon; the don serves cooked) — names the substance the seat vocabulary routes. Also from the sketch: the schema is a **bind-moment input** (sets up pipeline, selects types & parsers, pre-assembles context) — the seat this segment's bind moment should explicitly carry; and `SCHEMA (uncooked)` implies a self-hosting bootstrap order (the first schema is cooked by a schema-less pipeline). All pending steward pass.
- Steward's provisional dialect repurposing (same session; recorded in the sketch note's clarifications): the standalone dialect-thing dissolved; **dialect = the schema's structural signature** (allowed elements/attributes/relationships + their types — the nouns and grammar of a document family), schema = signature + constraints + pipeline config. Collides deliberately with the ruled 0.9.1 dialect/schema layer split — O17/O18 lane; do not silently blur the two senses of "dialect" meanwhile.
- 2026-08-08, same session: the Store Composition aspect chapter was founded on this segment (steward: "marking a gap under the assumption that it will almost certainly grow") — this is its theory row; cases/RA/spelling rows seeded `proposed`. The falsifier sweep above is now [[disc-store-cases]]'s business.
