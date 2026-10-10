# Feedback on the address-theory `def/` entries, from ai-risk-model (2026-10-08)

*From Claude (Opus 5.5), working with Joseph on `~/src/ai-risk-model`. That project imports these entries by reference, pinned at commit `90f4fb6`, under the namespace `addr:`. Its lexicon builder (`~/src/ai-risk-model/lexicon/build`) now renders this directory too, and `./build --check` surfaced most of what follows. I re-checked each item against the files with a script before writing it down. Nothing here has been changed in the entries; the decisions are yours.*

## 1. `@{referent}` names no term; the id is `referents`

`def-reference.ud` declares the term as `|term[referents]` (also in the group header). Ten references use the singular `@{referent}`:
- `def-binding.ud`: 4 (three times), 5, 15
- `def-location.ud`: 4
- `def-reference.ud`: 4, 10, 11
- `def-resolution.ud`: 16

These include the rels rows `:dual @{referent}` and `:referents @{referent} {0,N}`. The group's intro writes "**REFERENT**s", which reads as the singular term in the plural.

*Suggestion:* make the id `referent` (singular) to match how every reference uses it, or add `referent` as an alias. The rels row `:referents @{referent} {0,N}` reads correctly once the id is singular.

## 2. Plural references to singular terms

Five references use a plural form of a defined term:
- `@{bindings}`: def-scope:4
- `@{edges}`: def-scope:4; def-resolution:4
- `@{names}`: def-binding:5
- `@{references}`: def-generator:4
- `@{scopes}`: def-scope:4

A renderer can guess that `edges` means `edge`, and ours now does, but nothing in the entries says so. *Suggestion:* a stated convention, such as plural references resolving to their singular term, or writing them `@{edge}s` the way the intros write "**REFERENT**s".

## 3. Forward references to terms not yet defined

These are all in working notes or discussion, and each is described there as deferred:
- `@{ADDRESS}`: def-location:15, def-resolution:51
- `@{DIRECTIONS}`: def-resolution:51
- `@{TARGET-SET}`: def-reference:45
- `@{WORLD}`: def-scope:35

The upper case looks like a deliberate convention for terms not yet defined.

`@{moment}` is the exception. It is lowercase, and it is used as a relation *target* in `def-resolution.ud:15` (`:as-of @{moment} {1,1}`), as well as at :45 and :51. The entry's own working notes call it "load-bearing (not yet defined — see working notes)".

*Suggestion:* state the deferred-term convention in one place, so tools can report these as deferred rather than unresolved. Then either define `moment`, or mark it the same way as the others. Since a relation row depends on it, defining it may be the more useful of the two.

## 4. A discussion item that won't render as a list item

`def-reference.ud:32` begins its first `|discussion` item with "—" (an em dash), where every other item uses "-". Renderers that read markdown lists show it as a paragraph.

## 5. For the parser and spec, not the entries

udon's Rust parser (`core/target/debug/examples/stdin_parse`) warns on these files:
- `UnclosedIdentityKey` on padded keys like `|term[name      ]` in `def-binding.ud`;
- `AttributeAfterChildren` where `:status`, `:source` or `:synonyms` follow a term's text on the line above.

The agent that hardened the ai-risk-model lexicon builder reads both forms as valid under 0.10.0. If so, these are the parser lagging the spec, not problems in the entries. That is its reading of the spec, not a parser's verdict.
