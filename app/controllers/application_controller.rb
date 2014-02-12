class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :native_language, :has_native_language?

  before_filter :fetch_about_page
  before_filter :set_locale
  before_filter :authenticate
  before_filter :fetch_latest_contents

  def fetch_about_page
    @about_page = Page.find_by(slug: 'about')
  end

  def has_native_language?
    session[:selected_language_id] ||= current_user.language.id if user_signed_in? and current_user.has_assigned_language?
    session[:selected_language_id].present?
  end

  def native_language
    Language.find(session[:language_id] || build_native_language)
  end

  def fetch_advances(options)
    if user_signed_in?
      options[:user_id] = current_user.id
    else
      session[:unit_advance_token] ||= UnitAdvance.generate_session_token
      options[:session_token] = session[:unit_advance_token]
    end

    UnitAdvance.where(options)
  end

  private

  def build_native_language
    session[:language_id] = session[:selected_language_id]
    session[:language_id] ||= user_signed_in? ? current_user.language.id : Language.find(guess_locale).id
    change_locale
    session[:language_id]
  end

  def change_native_language(language)
    session[:selected_language_id] = session[:language_id] = language.id
    if user_signed_in?
      current_user.update_attribute 'language_id', language.id
    end
    change_locale
    Language.find(session[:language_id])
  end

  def change_locale
    if native_language.russian?
      I18n.locale = :ru
    else
      I18n.locale = :en
    end
  end

  def guess_locale
    available = %w{ru en}
    locale = http_accept_language.compatible_language_from(available)
    return locale.to_sym if locale.present?

    :en
  end

  def set_locale
    if params[:locale].present? && params[:locale] != native_language.slug
      return change_native_language(Language.find(params[:locale]))
    end

    change_locale if I18n.locale != native_language.slug
  end

  def authenticate
    return if ENV['LANGTRAINER2_LOGIN'].blank? || ENV['LANGTRAINER2_PASSWORD'].blank?

    authenticate_or_request_with_http_basic do |username, password|
      username == ENV['LANGTRAINER2_LOGIN'] && password == ENV['LANGTRAINER2_PASSWORD']
    end
  end

  def fetch_latest_contents
    @latest_contents = Unit.latest_contents
  end
end
