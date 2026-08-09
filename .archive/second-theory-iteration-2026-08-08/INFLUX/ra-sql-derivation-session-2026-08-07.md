# RA→SQL derivation working session — Arity & Designation chapters

**Register: ideation, wet clay.** Steward-requested working session (2026-08-07, evening): work one or two Part III chapters through theory → cases → RA → SQL+algebraic-types, to see what becomes possible or clear. Nothing here is canon; content that survives lands in the chapters' `disc-*-cases` / `form-*-ra` segments (and the SQL stage, whose outline home is itself an open steward question — the matrix agent's finding 3). Spelling deliberately untouched (stage law). SQL is a *lab*, not a proposal to ship SQL — the point is what the relational discipline forces us to decide.

## 0. The substrate schema (shared lab fixture)

MODEL.md rendered relationally, sugar already desugared:

```sql
CREATE TABLE node (
  node_id  INTEGER PRIMARY KEY,
  doc_id   INTEGER NOT NULL,
  parent   INTEGER REFERENCES node(node_id),  -- containment edge (NULL = top-level)
  pos      INTEGER NOT NULL,                  -- sibling order among parent's content
  kind     TEXT NOT NULL,                     -- element|text|comment|verbatim|directive|reference|blank
  name     TEXT                               -- NULL = anonymous
);

CREATE TABLE assignment (
  owner    INTEGER NOT NULL REFERENCES node(node_id),
  ord      INTEGER NOT NULL,                  -- per-owner stack order (source order)
  key      TEXT NOT NULL,                     -- includes designated keys: '$key','$traits','$?',…
  val_kind TEXT NOT NULL,                     -- str|int|float|bool|nil|list|envelope|node|flow|ref|interp
  val_text TEXT,                              -- scalar lexical form
  val_node INTEGER REFERENCES node(node_id),  -- edges may terminate at nodes
  PRIMARY KEY (owner, ord)
);
```

Three model facts carried faithfully, because each turns out load-bearing below: **(a)** attributes are ordered stacking edges — `(owner, ord)` PK, no uniqueness on `key`; **(b)** an edge terminates at a leaf (`val_text`) xor a node (`val_node`); **(c)** identity/traits are just assignment rows on `$key`/`$traits` — any "key index" is an *engine materialization*, licensed but never required.

---

# Chapter: Arity & Expectation

## 1. Theory in hand (from [[def-cardinality-and-resolution]], drafted)

Expected cardinality is part of the act's *type*; the four bounds give a miss its meaning. Double bound: **operational** `ar:{n,m}` (what the act will touch — divergence is failure) ⊥ **epistemic** `exp:{n,m}` (what the actor believes exists — divergence is dialogue/information). Recorded epistemic bounds = free calibration corpus. Six engine obligations, including typed outcomes and zero-only-from-completed-perspective (D7).

## 2. Cases and edges

- **C-A1 take-all:** "every decision with status open" — `ar:{0,N}`, no `exp`. Zero is the answer ∅.
- **C-A2 the-one-or-fail:** "`intent[311]`" — `ar:{1,1}`. Zero = my model is wrong (loud); two = collision (loud, with candidates).
- **C-A3 maybe-one:** "the `:deprecated` attribute if present" — `ar:{0,1}`. Zero is the answer *absent*.
- **C-A4 edit-first-expect-few (O15 verbatim shape):** operate on the first (`ar:{1,1}`, `sel:first`), expect no more than three (`exp:{1,3}`) — "or I've grossly misunderstood the data."
- **C-A5 graduated dialogue:** `exp` violated, `ar` satisfiable → not an error: "several exceed three — proceed anyway?" (interactive) / structured choices (machine caller).
- **C-A6 plural-selection policy:** matches > operational max → `sel:` decides: `fail` (default for `{1,1}`), `first`, `all`, `choices`, `queue`.
- **E-A1 match vs value multiplicity (demand-map trap 3):** `:fed-by` stacked 3× on one element vs 3 elements matching — different multiplicities, different failures (`PathNotUnique` vs a plural *stack*), and the RA must keep them in different seats.
- **E-A2 zero from a still-filling perspective:** `found-none-so-far`, never ∅ (D7).
- **E-A3 epistemic-only divergence:** found-one cleanly but `exp:{2,3}` — under-population is *also* information ("I expected several").

## 3. Reference acts (syntax-free)

The act carries `ar:{n,m}` (operational), optional `exp:{n,m}` (epistemic), `sel:policy`. Resolution against perspective P yields the match set R. Then, as two **independent channels** (the ⊥ made structural):

```
resolve : Act⟨ar, exp, sel⟩ × Perspective → Outcome⟨ar,sel⟩ × EpistemicReport⟨exp⟩

Outcome  = FoundOne(ref)
         | FoundMany(candidates)        -- ar violated above, sel:fail
         | FoundSelected(refs, note)    -- sel picked; disclosed, never silent
         | FoundNone                    -- only from attested-complete P
         | FoundNoneSoFar               -- P incomplete
         | FoundButWeakly(ref, via)     -- D6, composes orthogonally
EpistemicReport = InBounds | Diverged(|R|, exp)   -- never blocks; routes to dialogue
```

The operational bound selects the **sum branch**; the epistemic bound never touches the sum — it rides beside as a product component. An engine that folds `Diverged` into failure has re-conflated the two bounds; the type makes that a visible error.

**E-A1 resolved structurally:** act arity quantifies *referents* (|R|); stack multiplicity is quantified by the row type's per-key regex (type-algebra §2, σ with `{n,m}` exponents). Two different algebra homes — which is *why* conflating them is the trap. An act addressing "the value of `:fed-by` on X" needs both seats: `ar` over X (referent), and the stack answer typed by σ.

## 4. SQL derivation

C-A4 in full (`||intent[311]`, `ar:{1,1}` `sel:first`, `exp:{1,3}`):

```sql
WITH matches AS (
  SELECT n.node_id
  FROM node n
  JOIN assignment k ON k.owner = n.node_id AND k.key = '$key' AND k.val_text = '311'
  WHERE n.kind = 'element' AND n.name = 'intent'
    AND n.doc_id IN (SELECT doc_id FROM perspective_membership)
),
c AS (SELECT COUNT(*) AS n FROM matches)
SELECT
  CASE
    WHEN c.n = 0 AND NOT (SELECT attested_complete FROM perspective) THEN 'found-none-so-far'
    WHEN c.n = 0 THEN 'found-none'
    WHEN c.n = 1 THEN 'found-one'
    ELSE 'found-selected'            -- sel:first; candidates preserved below
  END                                            AS outcome,
  (SELECT MIN(node_id) FROM matches)             AS selected,      -- sel:first ≈ document order
  (SELECT json_group_array(node_id) FROM matches) AS candidates,   -- obligation: preserved
  CASE WHEN c.n NOT BETWEEN 1 AND 3
       THEN json_object('observed', c.n, 'expected', '{1,3}') END  AS epistemic_divergence
FROM c;
```

### What became clear (the findings)

**F-A1. SQL already has `{1,1}` — as its most notorious runtime error — and the double bound explains what SQL got wrong.** A scalar subquery (`= (SELECT …)`) *is* an operational `{1,1}`: more than one row → runtime error. `IN (SELECT …)` is `{0,N}`. SQL's failure is that it has **only** the hard operational channel — no epistemic seat, no typed outcome, no candidates preserved, no dialogue. The whole arity chapter can be stated as: *give the scalar-subquery discipline its missing outcome type and its missing second bound.* That's a one-sentence positioning of the aspect against 50 years of prior art.

**F-A2. One `{n,m}` axis, three enforcement moments — now mechanically distinct.** Schema cardinality = durable constraint (CHECK/trigger — rejects at *write*); operational arity = query semantics (the CASE — shapes the *outcome*); epistemic bound = report only (a column that never affects control flow). R4 said "one axis, four sites"; the SQL lab shows the sites differ precisely in *when and how hard they bind*. A disagreement between a schema `{n,m}` and a per-act `exp:{n,m}` is computable as a plain comparison — and per O15, that disagreement is itself information (stale schema or stale agent).

**F-A3. The typed-outcome obligation costs one CTE.** The naive query returns rows; the obligated query returns `(outcome, selected, candidates, epistemic_divergence)`. The delta is ~6 lines. "Never a silent best-guess" is cheap at the engine level — the expensive version is every consumer reimplementing it, which is the argument for it being an engine obligation in the first place.

**F-A4. `sel:first` forced a decision we hadn't named: *first by what order?*** Document order (`MIN(node_id)` is a stand-in) is only well-defined within one document; across a store, "first" needs the perspective to supply an ordering. So `sel:` policies have a hidden parameter — the ordering — that belongs to the *perspective*, not the act. New RA slot candidate discovered by the derivation, exactly what the SQL stage is for.

---

# Chapter: Designation & Aliases

## 1. Theory in hand ([[def-descriptors]] + [[def-entities-values-promises]], drafted; D8 fresh)

Designators bound by agreement, held by a naming community; failure modes dangle/collide. Entities minted/maintained by convention; nothing in content testifies to identity. Stacked designators for rename survival; resolve-by-one-verify-by-another (over-determination, with D6's found-but-weakly). Canonicity = four promise classes. D8: descriptor kind is determined by whether anyone keeps the binding — policing makes a designator; unpoliced degrades to description.

## 2. Cases and edges

- **C-D1 rigid lookup:** `intent[311]` — type-scoped natural key in community (store, `intent`-kind).
- **C-D2 rename survival:** slug `site` → `company-primary-url` (O4's worked example); old designator stays bound as alias through the expand-contract window; acts carrying either resolve to the same entity; resolution via the *retiring* designator is disclosed.
- **C-D3 resolve-by-one-verify-by-another:** act carries `[slug]` + `[#uuid]`; engine resolves by whichever it can, verifies the others co-refer; disagreement = loud contradiction (over-determination's second job).
- **C-D4 collision at mint:** second `intent[311]` enters the community → mint-time failure, not resolution-time surprise (D8: the fork made visible).
- **C-D5 retirement/lineage:** a designator is retired with a reason; later acts using it get the lineage answer ("retired 2026-08, successor X"), not a bare dangle.
- **E-D1 community scoping:** `[311]` unique per `(community, kind)`, not globally — partial identity is a good designator whose community is too large *or acts scoped to the wrong community*.
- **E-D2 the unpoliced boundary:** a stem over a directory nobody polices — the engine can't promise designator semantics; the act's outcome should say which semantics it actually got.

## 3. Reference acts (syntax-free)

`des:` conjunctions are kind-marked: `des:[slug:site]`, `des:[uuid:…]`, `des:[hash:…]` — the kind names the naming community + binding discipline. Multiple designators = over-determination: resolve by any, verify all. Lineage is first-class: designation *events* (mint, bind, rebind, retire(reason)) are the community's maintenance made durable; "the current binding" is a fold over them.

## 4. SQL derivation — and the event-sourced grounding

The community's ledger, exactly as the steward's event-sourcing instinct suggests:

```sql
CREATE TABLE designation_event (
  event_id   INTEGER PRIMARY KEY,
  at         TEXT NOT NULL,             -- moment
  op         TEXT NOT NULL,             -- mint | rebind | retire
  community  TEXT NOT NULL,             -- uniqueness scope (store, vault, kind, …)
  dkind      TEXT NOT NULL,             -- slug | uuid | hash | stem | …
  designator TEXT NOT NULL,
  entity_id  INTEGER NOT NULL,
  reason     TEXT,                      -- retire carries its why (O10's removal-reasons)
  promise    TEXT                       -- true-identity | canonical | preferred | working
);

-- The current binding IS a fold over events (any moment m is the same view with at <= m):
CREATE VIEW binding AS
SELECT community, dkind, designator, entity_id, promise
FROM designation_event e
WHERE op <> 'retire'
  AND event_id = (SELECT MAX(event_id) FROM designation_event
                  WHERE community = e.community AND dkind = e.dkind
                    AND designator = e.designator);
```

Mint-time collision policing (C-D4) is a check against the fold before insert; resolve-and-verify (C-D3) is a fan-out check:

```sql
-- act: des:[slug:widget-a] ∧ des:[uuid:9f3…], within community 'store:main'
SELECT COUNT(DISTINCT entity_id) AS distinct_referents,
       json_group_array(json_object('via', dkind, 'entity', entity_id)) AS resolutions
FROM binding
WHERE community = 'store:main'
  AND ((dkind='slug' AND designator='widget-a') OR (dkind='uuid' AND designator='9f3…'));
-- distinct_referents = 1 → verified co-reference (clean hit)
-- distinct_referents > 1 → loud contradiction (something moved / model stale)
-- rows < designators supplied → resolved via the subset that bound → found-but-weakly (D6)
```

### What became clear (the findings)

**F-D1. A naming community is a uniqueness scope, and a maintained binding is a unique constraint — D8 is standard database machinery wearing philosophy clothes.** Policing = the constraint enforced at mint (INSERT) time; collision = constraint violation, loud, before any resolution happens; unpoliced = no constraint, and the same string-match is just a predicate scan — a *description*. The designator/description cut is, operationally, **indexed-unique-lookup vs unconstrained-predicate** — the theory's central distinction lands on the most battle-tested distinction in data engineering.

**F-D2. The entity table is empty — and that's the theory confirmed, not a modeling failure.** `entity_id` appears only as a foreign target; entities have no attribute columns because *nothing in content testifies to identity* ([[def-entities-values-promises]] verbatim). An entity in the lab is literally a bare surrogate key plus its community's maintenance events. The definition survived contact with a schema designer's instincts.

**F-D3. Event-sourcing dissolves "silent re-satisfaction" mechanically — the steward's upstream-error claim checks out in the lab.** Against `designation_event`, every resolution is a fold to a moment; re-running the same act at the same moment is deterministic, and at a later moment the *delta is itself queryable* (the events between). "The world changed under my predicate" becomes "there are events I haven't looked at" — an ordinary query, not a distinctive failure mode. What remains of re-satisfaction is exactly one thing: **perspectives whose event log you don't hold** (a live filesystem, the open web) — un-attested membranes, which is D7's territory, not the descriptor definitions'. This is direct support for relocating/deleting the concept when the Temporal chapter drafts.

**F-D4. The four promises are a column, and promise-downgrade is an event.** `promise` on the binding row makes "what may I rely on" queryable without resolving anything (the design payoff [[def-entities-values-promises]] asks for), and a canonical-location breach is visible as a `rebind`/`retire` event on a `promise='canonical'` row — a breach is *in the record*, attributable, exactly what "canonicity is social" predicts a community ledger would show.

**F-D5. Aliases and O4's expand-contract window are the same fold.** `site` and `company-primary-url` both currently bound to one entity = the coexistence window as two live binding rows; contraction = `retire(site, reason)`. The `was:` mechanism O4 wants is a *designation event*, and the lineage answer for C-D5 (retired-with-successor, not bare dangle) falls out of querying past events — the ledger never dangles silently if the community never deletes events.

---

## 5. Cross-chapter residue (for the queue, not resolved here)

1. **`sel:` ordering is a perspective slot** (F-A4) — new RA anatomy candidate; feeds `form-act-anatomy` and the Origins chapter.
2. **The SQL-stage homelessness** (matrix agent finding 3) now has evidence: both derivations produced segment-worthy findings (F-A1, F-D1, F-D3) — the stage earns a home, whether as a fourth seed row or a section inside `form-*-ra`.
3. **F-D3 belongs to the Temporal chapter's adjudication** of re-satisfaction — cite it there.
4. **The perspective tables** (`perspective_membership`, `attested_complete`) were stubbed here — the lab needs the perspective decomposition (O13) before those become honest; another vote for that segment.
5. Register reminder: every SQL fragment above is illustrative shape, unexecuted — a real lab run (SQLite + a loaded corpus) is the cheap next step and would catch what armchair SQL misses.
