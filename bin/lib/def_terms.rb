# def_terms.rb — the term-linking conventions shared by the generated views
# (bin/compose-defs → LEXICON-overview.md; bin/compose-lexicon → LEXICON.md),
# so the two views cannot drift apart on how a term is linked.
#
#   @{term}     → *[[def-….ud|term]]*      term lives in another def file
#               → ==*term*==                term lives in this same file/group
#   **TERM**    → '**[[def-….ud|TERM]]**'   always linked; display keeps the CAPS
#   **TERM**s   (letters right after the bold) → the bold widened to TERMS when
#               that is a form of a term; otherwise TERM is linked and the
#               letters stay outside, reported as an undeclared form.
# For @{…}, display is the written surface, title-cased only at sentence start.
#
# FORMS. Each |term declares its own word forms (Joseph, 2026-10-09):
#
#   |term[referent] A thing that a reference is proxy for.
#     :pos noun
#     :pl  -s
#
#   :pos noun   — the base form, plus its plural from :pl:
#                 "-s" / "-es" (any "-suffix") appends; a whole word
#                 (`:pl ambiguities`) is the plural as written; no :pl means
#                 the noun has no plural (a mass noun).
#   :pos verb   — the base form, plus the regular inflections, made here:
#                 3sg  -s, or -es after s/x/z/ch/sh, or y→ies after a consonant
#                 past -ed, or -d after e, or y→ied after a consonant (also
#                      the past participle)
#                 ing  -ing, dropping a final silent e (resolve → resolving),
#                      ie → ying
#                 An irregular verb overrides any of them with :3sg, :past,
#                 :pp (past participle, when it differs from :past) or :ing,
#                 each a "-suffix" or a whole word, as :pl is.
#   :pos stacks (`:pos noun` + `:pos verb`) for a word used both ways; any
#   other :pos registers the base form only.
#
# A surface (lower-cased) resolves only through these declarations. A form no
# term declares is left as written and reported — never guessed. A term that
# declares no :pos falls back to the pre-2026-10-09 behaviour (dry-inflector's
# singular/plural guesses), reported as such, so files copied into repos that
# have not adopted :pos still link.

module DefTerms
  module_function

  MORPH_KEYS = %w[pos pl 3sg past pp ing].freeze

  # A term's declarations: its ids (first is the term), the file it lives in,
  # its :pos values and its form overrides ({"pl" => "-s", …}).
  Decl = Struct.new(:id, :aliases, :file, :line, :pos, :forms, keyword_init: true)

  # Outline order: the def slugs linked from the outline as [[def-….ud]].
  def outline_slugs(outline_path)
    File.read(outline_path).scan(/\[\[(def-[a-z-]+)\.ud\]\]/).flatten.uniq
  end

  # A light line scan for |term declarations (ids, and the :pos/:pl/… lines
  # that follow a |term line before any child element). bin/compose-defs
  # reads with this; bin/compose-lexicon reads with its own reader and checks
  # that the two agree.
  def scan_decls(path, file)
    decls = []
    cur = nil
    cur_indent = nil
    File.foreach(path, encoding: "UTF-8").with_index(1) do |line, n|
      next if line.strip.empty?
      indent = line[/\A */].size
      if (m = line.match(/\A(\s*)\|term((?:\[[^\]]*\])+)/))
        ids = m[2].scan(/\[([^\]]*)\]/).flatten.map(&:strip)
        cur = Decl.new(id: ids.first, aliases: ids.drop(1), file: file, line: n, pos: [], forms: {})
        cur_indent = m[1].size
        decls << cur
        next
      end
      next unless cur
      if indent <= cur_indent || line =~ /\A\s*[|;]/
        cur = nil # the term's own attribute lines are over
        next
      end
      if (m = line.match(/\A\s*:(#{MORPH_KEYS.join('|')})\s+(.*?)\s*(?:\s;(?:\s.*)?)?\z/o))
        add_decl_value(cur, m[1], m[2])
      end
    end
    decls
  end

  # One :pos/:pl/… value onto a Decl ("[noun verb]" lists allowed for :pos).
  def add_decl_value(decl, key, raw)
    words = raw.to_s.strip.sub(/\A\[(.*)\]\z/, '\1').split
    if key == "pos" then decl.pos.concat(words)
    else decl.forms[key] = words.first
    end
  end

  # "-s" appends; anything else is the whole word.
  def apply_form(base, spec)
    spec.start_with?("-") ? base + spec[1..] : spec
  end

  def consonant_y?(w) = w =~ /[^aeiou]y\z/

  def verb_forms(base, forms)
    third = if base =~ /(s|x|z|ch|sh)\z/ then base + "es"
            elsif consonant_y?(base) then base[0..-2] + "ies"
            else base + "s"
            end
    past = if base.end_with?("e") then base + "d"
           elsif consonant_y?(base) then base[0..-2] + "ied"
           else base + "ed"
           end
    ing = if base.end_with?("ie") then base[0..-3] + "ying"
          elsif base =~ /[^aeioy]e\z/ then base[0..-2] + "ing"
          else base + "ing"
          end
    out = { "3sg" => third, "past" => past, "ing" => ing }
    %w[3sg past ing].each { |k| out[k] = apply_form(base, forms[k]) if forms[k] }
    out["pp"] = forms["pp"] ? apply_form(base, forms["pp"]) : out["past"]
    out
  end

  # Every surface a declaration yields: [[surface, how], …].
  # how: "base", "alias", "pl", "3sg", "past", "pp", "ing".
  def declared_surfaces(d)
    out = [[d.id, "base"]] + d.aliases.map { |a| [a, "alias"] }
    out << [apply_form(d.id, d.forms["pl"]), "pl"] if d.pos.include?("noun") && d.forms["pl"]
    verb_forms(d.id, d.forms).each { |k, v| out << [v, k] } if d.pos.include?("verb")
    out.map { |s, how| [s.downcase, how] }.uniq(&:first)
  end

  # Build the surface map from declarations, in reading order.
  #   term_map:  surface → def file   (what rewrite_terms consults)
  #   info:      surface → { id:, file:, how:, guessed: }
  # Problems found while building are appended to +notes+ as hashes
  # { kind:, file:, line:, msg: } for the caller to report.
  def build_term_map(decls, header_only, inflector, notes)
    term_map = {}
    info = {}
    claim = lambda do |surface, d_id, file, line, how, guessed|
      if (prev = info[surface]) && prev[:id] != d_id
        notes << { kind: :form_clash, file: file, line: line,
                   msg: "`#{surface}` is a form of both `#{prev[:id]}` (#{prev[:file]}) and `#{d_id}`; it links to `#{prev[:id]}`" }
        next
      end
      next if prev
      term_map[surface] = file
      info[surface] = { id: d_id, file: file, how: how, guessed: guessed }
    end

    declared, undeclared = decls.partition { |d| d.pos.any? }
    declared.each do |d|
      (d.pos - %w[noun verb]).each do |p|
        notes << { kind: :pos, file: d.file, line: d.line,
                   msg: "`#{d.id}` has `:pos #{p}`, which the tools don't inflect; only its base form links" }
      end
      if d.forms["pl"] && !d.pos.include?("noun")
        notes << { kind: :pos, file: d.file, line: d.line, msg: "`#{d.id}` declares `:pl` but not `:pos noun`; the plural is not registered" }
      end
      (d.forms.keys & %w[3sg past pp ing]).each do |k|
        next if d.pos.include?("verb")
        notes << { kind: :pos, file: d.file, line: d.line, msg: "`#{d.id}` declares `:#{k}` but not `:pos verb`; the form is not registered" }
      end
      declared_surfaces(d).each { |s, how| claim.(s, d.id, d.file, d.line, how, false) }
    end
    # Fallback: the old guesses, only for terms that declare nothing.
    (undeclared + header_only).each do |d|
      notes << { kind: :undeclared, file: d.file, line: d.line,
                 msg: (d.line ? "`|term[#{d.id}]` declares no `:pos`" : "`#{d.id}` is named in its group header but has no `|term`") +
                      "; its forms were guessed (dry-inflector), as before :pos existed" }
      guesses = [d.id, inflector.singularize(d.id), inflector.pluralize(d.id),
                 inflector.pluralize(inflector.singularize(d.id)), inflector.singularize(inflector.pluralize(d.id))]
      (guesses + d.aliases).map(&:downcase).uniq.each do |s|
        claim.(s, d.id, d.file, d.line, s == d.id.downcase ? "base" : "guessed", s != d.id.downcase)
      end
    end
    [term_map, info]
  end

  # The base word a surface most plausibly comes from, for a hint when the
  # surface itself is undeclared (a hint only — nothing is linked by it).
  def nearest_term(surface, info, inflector)
    s = surface.downcase
    stems = [inflector.singularize(s), s.sub(/ies\z/, "y"), s.sub(/ied\z/, "y"), s.sub(/es\z/, ""),
             s.sub(/s\z/, ""), s.sub(/ed\z/, ""), s.sub(/d\z/, ""), s.sub(/ing\z/, ""), s.sub(/ing\z/, "e")]
    stems.reject { |c| c == s }.map { |c| info[c] && info[c][:id] }.compact.first
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

  def resolve_def(term_map, slug)
    term_map[slug.downcase]
  end

  # Rewrite @{term} and **TERM** (optionally followed by letters) using the
  # term→def map. +home_def+ is this section's own def file: same-file @{…}
  # becomes emphasis only; cross-file becomes a wikilink. Unmapped tokens are
  # left alone and listed in +unmapped+.
  #
  # +pipe+ is the separator written inside a wikilink: "|" normally, "\\|"
  # inside a markdown table row (where a bare | would end the cell).
  # +on_ref+, if given, is called as on_ref.(surface, def_file_or_nil, kind)
  # for every @{…} (kind :ref) and **TERM** (kind :bold) seen, so a caller
  # can account for each one; for a **TERM**suffix whose suffix makes no
  # declared form, it is called with the whole surface and kind :bold_suffix.
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
        on_ref&.call(surface, def_file, :ref)
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
      elsif (m = rest.match(/\A\*\*([A-Z][A-Z0-9-]*)\*\*([a-z]+)?/))
        caps = m[1]
        suffix = m[2] # letters right after the bold in source: **REFERENT**s
        slug = caps.downcase
        # Fold a suffix that makes a form into the CAPS display, so bold wraps
        # a complete wikilink — '**[[…|REFERENT]]**s' breaks bold close in
        # Obsidian; '**[[…|REFERENTS]]**' does not.
        if suffix && (def_file = resolve_def(term_map, slug + suffix))
          on_ref&.call(slug + suffix, def_file, :bold)
          out << "'**[[#{def_file}#{pipe}#{caps}#{suffix.upcase}]]**'"
          i += m[0].length
        elsif (def_file = resolve_def(term_map, slug))
          on_ref&.call(suffix ? slug + suffix : slug, def_file, suffix ? :bold_suffix : :bold)
          out << "'**[[#{def_file}#{pipe}#{caps}]]**'"
          i += caps.length + 4 # the suffix, if any, stays as written after it
        else
          on_ref&.call(suffix ? slug + suffix : slug, nil, :bold)
          unmapped << "**#{caps}**#{suffix}"
          out << m[0]
          i += m[0].length
        end
      else
        out << text[i]
        i += 1
      end
    end
    out
  end
end
