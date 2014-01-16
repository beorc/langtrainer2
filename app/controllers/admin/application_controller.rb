class Admin::ApplicationController < ApplicationController
  include SitemplateCore::Admin::ApplicationControllerBase
  helper_method :current_locale, :globalized, :globalized_hint

  def default_url_options
    return super if params[:globalize_locale].blank?
    { globalize_locale: params[:globalize_locale] }.merge(super)
  end

  protected

  def globalized_hint(object, attribute)
    if current_locale == :ru
      locale = :en
    else
      locale = :ru
    end

    I18n.with_locale(locale) { object.send(attribute) || 'Требуется перевод' }
  end

  def globalized(&blk)
    I18n.with_locale(current_locale, &blk)
  end

  def current_locale
    params[:globalize_locale].try(:to_sym) || I18n.locale
  end

  def has_native_language?
    if user_signed_in? and current_user.has_assigned_language?
      session[:selected_language_id] ||= current_user.language.id
    end
    session[:selected_language_id].present?
  end
end

