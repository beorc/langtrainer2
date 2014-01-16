module ApplicationHelper
  def title_for(slugged)
    I18n.t(['titles', slugged.class.model_name.name.downcase, slugged.slug].join('.'), default: slugged.title)
  end

  def active_language_class(language)
    native_language.id == language.id ? 'active' : ''
  end

  def render_language_characters(language)
    render partial: 'shared/language_characters', locals: { language: language.to_s }
  end
end
