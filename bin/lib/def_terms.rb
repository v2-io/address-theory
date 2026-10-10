# def_terms.rb — the term-linking conventions shared by the generated views
# (bin/compose-defs → LEXICON-overview.md; bin/compose-lexicon → LEXICON.md).
#
# Extracted unchanged from bin/compose-defs (conventions settled 2026-08-10;
# see CHANGELOG) so the two views cannot drift apart on how a term is linked.
#
#   @{term}   → *[[def-….ud|term]]*        term lives in another def file
#             → ==*term*==                  term lives in this same file/group
#   **TERM**  → '**[[def-….ud|TERM]]**'     always linked; display keeps the CAPS
#
# The term map is built from live |term-group[…] ids; singular/plural surfaces
# are expanded with dry-inflector so @{reference}/@{references} reach one file.
# For @{…}, display is the written surface, title-cased only at sentence start.

module DefTerms
  module_function

  # Outline order: the def slugs linked from the outline as [[def-….ud]].
  def outline_slugs(outline_path)
    File.read(outline_path).scan(/\[\[(def-[a-z-]+)\.ud\]\]/).flatten.uniq
  end

  def title_case_first(s)
    return s if s.empty?
    s[0].upcase + s[1..]
  end

  # Hyphen-segment title case: intended-cardinality → Intended-Cardinality
  def title_case_term(s)
    s.split("-").map { |w| w.empty? ? w : w[0].upcase + w[1..] }.join("-")
  end

  # Position is a sentence start if nothing precedes it, or the nearest
  # non-whitespace character before it is . ? or !
  def at_sentence_start(text, pos)
    return true if pos <= 0
    i = pos - 1
    i -= 1 while i >= 0 && text[i] =~ /\s/
    return true if i < 0
    ".?!".include?(text[i])
  end

  # Register a term slug and its singular/plural variants under one def file.
  # Canonical entries come from |term-group|; inflection fills the rest so
  # authors can write whichever surface the sentence wants.
  def register_term!(term_map, inflector, term, def_file, warn_prefix: "compose-defs")
    surfaces = [term, inflector.singularize(term), inflector.pluralize(term)]
    # Also: if the entry is already plural, singularize then re-pluralize
    # covers irregular pairs dry-inflector knows (and is a no-op otherwise).
    surfaces << inflector.pluralize(inflector.singularize(term))
    surfaces << inflector.singularize(inflector.pluralize(term))
    surfaces.map { |s| s.downcase }.uniq.each do |surface|
      existing = term_map[surface]
      if existing && existing != def_file
        warn "#{warn_prefix}: surface #{surface.inspect} claimed by both " \
             "#{existing} and #{def_file} (keeping #{existing})"
        next
      end
      term_map[surface] = def_file
    end
  end

  def resolve_def(term_map, slug)
    term_map[slug.downcase]
  end

  # Rewrite @{term} and **TERM** (optional trailing s outside the bold) using
  # the live term→def map. +home_def+ is this section's own def file: same-file
  # @{…} becomes emphasis only; cross-file becomes a wikilink. Unmapped tokens
  # are left alone; listed in +unmapped+.
  #
  # +pipe+ is the separator written inside a wikilink: "|" normally, "\\|"
  # inside a markdown table row (where a bare | would end the cell).
  # +on_ref+, if given, is called as on_ref.(surface, def_file_or_nil) for
  # every @{…} seen, so a caller can account for each one.
  def rewrite_terms(text, term_map, home_def, unmapped, pipe: "|", on_ref: nil)
    out = +""
    i = 0
    while i < text.length
      rest = text[i..]
      if (m = rest.match(/\A@\{([a-z][a-z0-9-]*)\}/i))
        # Surface as written (authors write @{scopes}/@{references}/…);
        # lookup is case-insensitive.
        surface = m[1]
        slug = surface.downcase
        def_file = resolve_def(term_map, slug)
        on_ref&.call(surface, def_file)
        if def_file
          display = at_sentence_start(text, i) ? title_case_first(slug) : slug
          if def_file == home_def
            # Same group/file: Obsidian highlight + emphasis; no self-wikilink.
            out << "==*#{display}*=="
          else
            out << "*[[#{def_file}#{pipe}#{display}]]*"
          end
        else
          unmapped << "@{#{surface}}"
          out << m[0]
        end
        i += m[0].length
      elsif (m = rest.match(/\A\*\*([A-Z][A-Z0-9-]*)\*\*(s)?/))
        caps = m[1]
        trailing_s = m[2] # "s" or nil — plural marker outside the bold in source
        slug = caps.downcase
        # Fold trailing s into the CAPS display so bold wraps a complete
        # wikilink — '**[[…|REFERENT]]**s' breaks bold close in Obsidian;
        # '**[[…|REFERENTS]]**' does not. Lookup uses the lowercased surface.
        surface_lower = trailing_s ? slug + trailing_s : slug
        display_caps  = trailing_s ? caps + trailing_s.upcase : caps
        def_file = resolve_def(term_map, surface_lower) || resolve_def(term_map, slug)
        if def_file
          out << "'**[[#{def_file}#{pipe}#{display_caps}]]**'"
        else
          unmapped << "**#{caps}**#{trailing_s}"
          out << m[0]
        end
        i += m[0].length
      else
        out << text[i]
        i += 1
      end
    end
    out
  end
end
