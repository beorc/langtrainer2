module Admin::ApplicationHelper
  def render_language_selector
    render 'admin/shared/top_bar/language_selector_control'
  end

  def translation_for(obj)
    obj.translations.find_by_locale(current_locale) || obj
  end

  def locale_class(locale)
    current_locale = params[:globalize_locale] || I18n.locale
    return 'active' if current_locale.to_s == locale.to_s
    'inactive'
  end

  def change_language_path(locale, param='locale')
    current_locale = params[param] || I18n.locale
    return '#' if current_locale.to_s == locale.to_s
    url_for(param.to_sym => locale)
  end
end
