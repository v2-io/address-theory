---
slug: obs-address-components
form: observation
type-expected: observation
status: empirical
max: empirical
state: [drafted]
depends: [def-descriptors, def-locations-and-paths]
---

# Observation: Address Components in the Wild

A brief survey of the location, identity, and description components that real systems compose into addresses.

## Formal Expression

*[Observation (component-survey)]*

**Common Location Components (Digital).** Often positional (Street → City → State, Postal Code, Country):

- Server: either name (for DNS) or address (IP) with implicit or explicit port — itself a location-vs-named-identity decision.
- Location — note the URI/URN/URL possible conflation of path, destination, and identity; per [[def-locations-and-paths]] that is the "Universal…" in the names presupposing UNIVERSAL LOCATION, the condition under which they interchange safely:
  - Namespace⁺: hierarchy of namespaces (NID + NSS in typical URNs).
  - Path⁺: hierarchy of (logical) containers — sometimes mapping directly to filesystem directories.

**Common Identity Components:**

- "Identifier": often simply the last element of a URI path or filesystem path — the "file-name," which is sometimes a directory-type file, so an intermediate location otherwise.
- {Server → DB → Table → *Surrogate Key*} (unique only all together).
- {Server → DB → Table → *Natural Key*} (sometimes unique all together, sometimes natural key + table alone, etc.).
- {*UUID*}: a pure *universal identity* — like Santa Claus, it may distinctively identify something while, unlike Santa Claus, its location may be unknown; and as with Santa Claus, the path to it may be fraught with danger. Several versions with different trade-offs (lexical sorting, generation speed). Just super ugly.

**Common Description Components** (the third mode, usually unlabeled in the wild):

- Predicate filters: SQL `WHERE`, CSS selector classes/pseudo-classes, XPath predicates `[...]`, attribute/trait filters.
- Patterns over names: globs, stem-matching — wikilinks resolve by stem-match over a scope, *a description wearing a designator's clothes*, which is why stem collisions surprise people ( [[def-cardinality-and-resolution]]'s unstated-{1,1}).
- Content addresses: the limiting case where the description is complete and compressed to fixed size (hash) — see [[def-entities-values-promises]].

**Deliberately absent for our purposes** (sometimes part of a URL): Scheme, Authentication, Filetype (the `.xyz` suffix as data/document-type shorthand). Absent from *this survey's* scope, not adjudicated out of the model — the O13 perspective decomposition treats scheme/host as perspective rungs and suffix as expected-return-type, and those homes are Part II's business.

## Epistemic Status

Empirical survey; organizing labels inherited from the Part I definitions. Not exhaustive and not attempting the formalisms survey's depth — this is the field-components inventory the definitions must be able to classify, and each bullet is a classification exercise passed.
