# What a resolution yields, and when — thoughts and options for the steward

*From Claude (Opus 5.5), 2026-10-09. A working note for a decision that is Joseph's; nothing here is ruled. It takes up §4 of `inf/SOLIDIFICATION-PASS-2026-10-09.md` together with Joseph's remark of the same day, quoted below. Where I lean, I say so and why; where I rely on general knowledge rather than a primary in `ref/`, I say "(recall)".*

> "I think one of the main things that I think (if I understand correctly) becomes part of the moment split is the equivalent of "compile-time" and "run-time" -- with notation though like udon it would be at document-parse time (just like a C preprocessor or elixir macros) vs things that get resolved later in a dynamic environment (an udon "don" store, or launch-time and again during runtime with code etc. etc.)..."
>
> — Joseph, 2026-10-09

## 1. The compile-time / run-time point, in the theory's own words

I think this is right, and the theory already has the vocabulary to say it precisely. `def-generator`'s discussion has it: a deferred item can be **held** ("kept as a value instead of reached through") or **reached through** (resolved, dereferenced, evaluated). Compile time vs run time is that same choice placed in time. A preprocessor or a macro reaches through *early*, at the stage where the document is assembled. A live configuration lookup or a store query *holds* the item until a later stage and reaches through there.

So the proposal is:

> **Staging is the temporal face of hold vs reach-through.** A pipeline has stages (assembly, load, request, run, …). A *schedule* says, for each deferred item, at which stage it is reached through; before that stage it travels held.

The steward's 2026-08-08 notebook pages already had this, as a question: "Path desegmentation — Before or after (or both) liquid rendering → A: Pipeline decision to make!", and "Liquid assembly … On ingest vs On request". The archived second edition gave the store spec (DON) the job of "decider of resolution moments" (its D9).

On udon specifically: recognition (parsing) never determines anything. References are inert, and resolution is the consumer's (primer §4.6). So udon's earliest stage is not parse time but **assembly**, the first consumer pass, which is where a C preprocessor or an Elixir macro sits. Parsing is like lexing; assembly is like macro expansion.

Prior names for this, from programming-language work (recall, not in `ref/`): *binding time* (the classic list: language-design, compile, link, load, run time); partial evaluation's *static* vs *dynamic* inputs; *multi-stage programming*. One naming caution: "binding time" uses *binding* for what this theory calls resolution, so it collides with `def-binding`. "Stage" carries no such collision, and udon's pipeline talk already uses it.

## 2. The moment, split

At least three moments are in play in every determination. I suspect they're all the split needs.

| Moment | Belongs to | Question it answers | Example |
|---|---|---|---|
| **written** | the reference (artifact) | When was the intent fixed? | The envelope was addressed on Monday |
| **performed** | the determination (the act) | At which stage and clock time was it reached through? | The carrier read it Thursday; the build ran at 14:02 |
| **as-of** | the determination's question | Against which state of the world? | Who lived there *on the date of the incident*; config *at deploy* |

Two things fall out.

- **`resolve`'s "now" and the intro's "a moment" are both right.** A determination is always *performed* now; it may be *as of* another moment. By default as-of = performed, which is why "as of now" reads naturally. Past-state queries ("what did this reach on 2026-01-01?") and pinned versions separate them. (This is `inf/DEF-FIXES-PROPOSED-2026-10-09.md` B2.)
- **ai-risk-model's D-bitemporal is exactly performed vs as-of.** Its `read_as_of` is when we performed the reading; its `evaluated_at` is the moment the statute's test applies (the developer's conduct). Database work calls these transaction time and valid time (recall).

*Stage* is a refinement of *performed*: not just when on the clock, but at which point in which pipeline.

## 3. Each stage boundary is a writing/use gap

This is the part I'd weight most. When a stage reaches through early, it **produces new recorded material**: the inlined value, the expanded text, the linked library. That material is then used at later stages, while the world goes on moving. So the theory's founding gap (written at one moment, used at another) reappears at every stage boundary. The early result is a snapshot, honest only as-of its performed moment.

Known shapes of this, all recall:

- **Static vs dynamic linking.** Static reaches through at build: no dangling at run time, but stale. Dynamic holds until load: current, but it can dangle.
- **DNS caching.** A resolution is reused for a stated time-to-live, then re-resolved.
- **Elixir's `Application.compile_env` vs `get_env`.** A compile-time read is recorded, and at boot Elixir checks that the value hasn't changed since compile time, raising if it has. That is *reach early, carry a check, verify at the later stage*: the archived reach/check idea, already built into a mainstream language.

What I'd take from this: **whatever an early stage produces should carry its as-of, and ideally a check against the world it read.** Without that, a held-then-inlined value is indistinguishable from one that was always literal.

## 4. What a resolution yields

The literature resolves to *declarations*. `def-resolution` resolves to *referents*. The case that separates them is a name bound to something that is itself deferred, such as a statutory definition (a test) or a config entry that points at another reference. Three options:

**R-A. Referents, always (as now).** Resolution reaches all the way through. Simple, but it can't say "one definition found" separately from "these three companies are covered", and that is exactly what ai-risk-model had to record.

**R-B. Bindings, always (the literature).** Resolution stops at the binding. This fails for matches, which consult no binding: a glob's results are files, not declarations.

**R-C. What the final connection delivers, held or reached through by schedule (my lean).** A result is ⟨path, the item the final connection delivered⟩. For a binding, that's the binding's referent; for a match, a member of the population. If that item is itself deferred material, it is **held** unless the schedule says to reach through it at this stage, in which case that is a further determination with its own path, performed moment and as-of.

Why R-C: it keeps `def-resolution`'s referent-based reading for every ordinary case, avoids R-B's failure on matches, and makes the deferred case explicit instead of hiding it. And it is the same hold vs reach-through choice as §1, so staging and result level become one mechanism rather than two.

A composite example (udon references as ruled in 0.9.1: `@name[key]`):

```udon
|service[api] :db @database[primary]
|database[primary] :host @env[DB_HOST] :port 5432
```

| Schedule | At assembly | At run | What `service[api]`'s `:db` carries after assembly |
|---|---|---|---|
| everything early (preprocessor-like) | reach through `@database[primary]`, then `@env[DB_HOST]` | — | the database's values, host inlined, as-of assembly; stale if `DB_HOST` changes |
| twelve-factor style | reach through `@database[primary]` | reach through `@env[DB_HOST]` | the database node, with `:host` still a held reference |
| everything late | — | both | the held reference `@database[primary]` |

Under R-C all three are the same resolution with different schedules. Under R-A only the first can be stated; under R-B the second line is natural but the first can't be stated.

The statute case: resolving "catastrophic risk" in SB 53's Labor Code limb reaches one binding, §1107(a), whose referent is a test. ai-risk-model's resolution records *hold* it ("outcome: one", one definition). Asking whether a given incident is covered *reaches through* the test, as-of the conduct date, performed when we read it. R-C states both, and keeps them apart.

## 5. Who chooses the stage

**S-A. The consumer only.** The schedule is consumer policy, nothing in the document. This matches udon's layering (the core never determines; resolution is a consumer menu). The 0.10.1-draft glossary had this: "Schedule — a consumer's assignment of determinations to stages/origins/moments; not a language object".

**S-B. The reference may bound it.** Some references only make sense at certain stages. A C `#include` must be reached through before compilation; a live-status reference must not be frozen at build. Real systems let the writer say so: C++ `consteval` (recall), Elixir `compile_env` vs `get_env`. That is writer's intent, the same kind of thing as intended cardinality, and it would sit on the reference the same way: an allowed range of stages ("no later than assembly", "not before run").

**S-C. The store declares per seat.** DON, or any host, declares stage policy for regions it serves (the second edition's "per-seat moments"). This is one form of S-A, the consumer being the store.

**My lean: S-A by default, with S-B as an optional bound on the reference.** That is udon's own "menu vs knob" rule: the writer may narrow the menu (the stages at which this reference is meaningful), and the consumer picks within it. Most references would say nothing. The ones that do are carrying real intent, and a consumer that violates it gets a named failure, not a silent stale value or a dangle.

## 6. A related question this raises: origins under staging

When a generator is evaluated early (a macro, a template at assembly), its output may contain references. **From which origin do those resolve:** where the generator was written, or where its output lands? This is macro *hygiene*. ESOP 2015 cites it in its related work ("Avoiding capture is also the basis of hygienic macros in Scheme", Dybvig; Herman & Wand). The C preprocessor is unhygienic (its output resolves where it lands); Scheme and Elixir macros are hygienic by default, with an explicit escape (recall).

`def-generator` says evaluation happens "from an origin" but not which origin the *produced* references get. My lean is to follow the hygienic default: produced references keep their writing origin unless the generator explicitly hands them the landing origin. But it's a real choice, and udon's directives (`!for`, `!if`, templates) will meet it the first time a template is expanded in one document and its references point into another.

## 7. What this would settle

- **B2**: `resolve` keeps "now" for the performed moment; "as of a moment" is the as-of, defaulting to now.
- **ai-risk-model D-bitemporal**: performed vs as-of. **D-bound-vs-match**: R-C's hold vs reach-through. **D-resolution-status**: a deferred item not yet scheduled is *held*. An item whose stage has come but which wasn't followed is *delegated*, an open critical edge in Rouvoet 2020's terms, as in the solidification pass §4.
- **The archived D7** ("zero only from a completed perspective") and **reach/check** both find a home: D7 as the stability of an answer performed before the world finished changing, reach/check as the check an early stage carries forward.
- **`def-generator`'s open questions**: "evaluation policy" becomes the schedule (§5); "output seating" and the origin of produced references are §6.

## 8. What I'd need from you

1. **R-A, R-B or R-C** (my lean: R-C).
2. **Do the three moments (written, performed, as-of) look like the right split**, and is "stage" the right word for where in a pipeline? Would you rather name them yourself?
3. **S-A, S-B or S-C** for who chooses the stage (my lean: S-A by default, S-B allowed).
4. **Hygiene default** for generators' produced references (my lean: hygienic, with an explicit escape).

With those, I can draft `def-` entries for the moment (or moments), stage and schedule, and the R-C changes to `def-resolution`, as proposals in the same form as `DEF-FIXES-PROPOSED`.
