<!-- GENERATED VIEW — do not edit by hand; regenerate with `bin/compose-defs`

The foundation term-groups' narrative intros, in outline (dependency) order —
one continuous reading pass over what the formal |term[ entries then pin down.
Source: leading prose of each def/*.ud linked from ADDRESSING-THEORY.outline.md.
Term links derived each run from live |term-group[…] headers; singular/plural
surfaces expanded via dry-inflector.
-->

# LEXICON overview

## Reference
*(  Reference  ·  Referent  ·  Intended-Cardinality  ·  Resolve  ·  Dereference  )*

A '**[[def-reference.ud|REFERENCE]]**' is recorded material that is used as a proxy or to stand in for its '**[[def-reference.ud|REFERENTS]]**', often when the ==*referents*== are not at hand or can't be known yet. The two terms are only well-defined in relation to each other. A ==*reference*== has an *intent* when it is created— and we specifically define the recorded '**[[def-reference.ud|INTENDED-CARDINALITY]]**' of a ==*reference*==: Whether it intends to stand in for a single ==*referent*== {1,1}, at most one{0,1}, or, for example, as many as there might be {0,N}. To '**[[def-reference.ud|RESOLVE]]**' a ==*reference*== is to determine what it reaches — always *as of a moment*; to '**[[def-reference.ud|DEREFERENCE]]**' it is to ==*resolve*== and take hold of the ==*referents*== as they then stand.

## Binding
*(  Binding  ·  Name  ·  Mint  ·  Maintainer  ·  Dangle  ·  Collide  )*

A '**[[def-binding.ud|BINDING]]**' is the first of the two mechanisms by which a *[[def-reference.ud|reference]]* actually reaches its *[[def-reference.ud|referents]]* (the other is *[[def-match.ud|match]]*): someone (the '**[[def-binding.ud|MAINTAINER]]**') deliberately associates ('**[[def-binding.ud|MINTS]]**') a '**[[def-binding.ud|NAME]]**' with a *[[def-reference.ud|referent]]* and keeps that association (==*binding*==) alive. Everything about a ==*binding*== is a fact about that upkeep, not the ==*name*== or the *[[def-reference.ud|referent]]*. The maintenance involved fails when the ==*binding*== no longer reaches a *[[def-reference.ud|referent]]*, called a '**[[def-binding.ud|DANGLE]]**', or when the ==*maintainer*== has more than one ==*mint*== of the same ==*name*== (they '**[[def-binding.ud|COLLIDE]]**').

The ==*name*== can be considered a new {1,1} *[[def-reference.ud|reference]]* to a *[[def-reference.ud|referent]]* that is more direct. The uniqueness of ==*names*== is a *norm* a ==*maintainer*== may police (cheapest at mint time) in order to avoid collision failures, instead of an invariant.

## Match
*(  Match  ·  Designator  ·  Description  )*

A '**[[def-match.ud|MATCH]]**' is the second mechanism by which a *[[def-reference.ud|reference]]* reaches its *[[def-reference.ud|referents]]*: instead of consulting a maintained *[[def-binding.ud|binding]]*, a test is run at the moment of use. With *[[def-binding.ud|binding]]* it forms the two connection mechanisms, and the classic vocabulary — '**[[def-match.ud|DESIGNATOR]]**' and '**[[def-match.ud|DESCRIPTION]]**' — derives from which mechanism a *[[def-reference.ud|reference]]*'s connection actually uses, never from how it is spelled.

## Scope
*(  Scope  ·  Edge  ·  Containment  ·  Root-Scope  )*

A '**[[def-scope.ud|SCOPE]]**' makes *[[def-binding.ud|binding]]*'s informal "jurisdiction" precise: it is the unit within which *[[def-binding.ud|bindings]]* are kept and collisions counted. ==*Scopes*== connect to one another by labeled '**[[def-scope.ud|EDGES]]**'; the universal edge label is '**[[def-scope.ud|CONTAINMENT]]**' — pointing from a ==*scope*== to the ==*scope*== enclosing it — and a ==*scope*== with no outward containment edge is a '**[[def-scope.ud|ROOT-SCOPE]]**'. This arrangement is the economics the whole theory rides on: a *[[def-binding.ud|binding]]* need only be unambiguous *locally*, within its ==*scope*==, and locally-cheap *[[def-binding.ud|bindings]]* compose across ==*edges*== into global reach. No *[[def-binding.ud|maintainer]]* ever needs a globally unique *[[def-binding.ud|name]]*.

## Location
*(  Location  )*

A '**[[def-location.ud|LOCATION]]**' is what you get when a *[[def-scope.ud|scope]]* is itself the *[[def-reference.ud|referent]]* of a *[[def-binding.ud|binding]]* — a named *[[def-scope.ud|scope]]*. Location-ness is a role a *[[def-scope.ud|scope]]* plays when some enclosing jurisdiction keeps a *[[def-binding.ud|name]]* for it, not a new kind of thing.

## Resolution
*(  Resolution  ·  Origin  ·  Resolution-Path  ·  Walk-Step  ·  Mediated-Step  ·  Admissibility  ·  Preference  ·  Ambiguity  )*

'**[[def-resolution.ud|RESOLUTION]]**' is where everything above comes together: a *[[def-reference.ud|reference]]*, resolved from an '**[[def-resolution.ud|ORIGIN]]**' *[[def-scope.ud|scope]]*, is worked back to the *[[def-reference.ud|referents]]* it reaches as of that moment. Each result carries its '**[[def-resolution.ud|RESOLUTION-PATH]]**' — the route that justifies it, made of '**[[def-resolution.ud|WALK-STEPS]]**' (traversals of standing *[[def-scope.ud|edges]]*) and '**[[def-resolution.ud|MEDIATED-STEPS]]**' (*[[def-scope.ud|edges]]* that exist only through a sub-==*resolution*==). The answer is shaped by declared policy — '**[[def-resolution.ud|ADMISSIBILITY]]**' (which path shapes count at all) and '**[[def-resolution.ud|PREFERENCE]]**' (which admissible results win) — and every outcome has standing, including none and too-many ('**[[def-resolution.ud|AMBIGUITY]]**').

