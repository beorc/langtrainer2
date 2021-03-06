module UnitsHelper
  def unit_path(unit)
    File.join('units/hints', unit.course.slug.to_s, unit.slug.to_s)
  end

  def unit_partial(unit, partial)
    File.join(unit_path(unit), partial.to_s)
  end

  def lang_hint_partial(unit, partial)
    File.join(hints_path(unit), partial.to_s)
  end

  def hints_path(unit)
    unit_partial(unit, @language.slug)
  end

  def hint_present?(unit)
    File.exists? Rails.root.join('app/views', hints_path(unit), "_#{native_language.slug}.html.slim")
  end

  def hint_partial(unit)
    lang_hint_partial(unit, native_language.slug)
  end

  def t(key, options = {})
    return super if I18n.locale == native_language.slug and !options[:foreign]
    return super unless options[:hint]

    if options[:foreign]
      locale = @language.slug
    else
      locale = native_language.slug
    end

    I18n.with_locale(locale) { I18n.t(key, options) }
  end
end
