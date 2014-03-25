class User::Charts::BaseController < ApplicationController
  layout 'user_profile'

  before_filter :authenticate_user!

  helper_method :render_courses_select,
                :render_units_select,
                :render_languages_select,
                :render_periods_select

  has_scope :with_course, as: :course_id
  has_scope :with_unit, as: :unit_id
  has_scope :with_language, as: :language_id
  has_scope :with_period, as: :period_id

  def default_url_options(options = {})
    [:course, :unit, :language, :period].each do |option|
      key = "#{option}_id".to_sym
      options.merge!({ option => params[key] }) if params[key].present?
    end
    options
  end

  def show
    @course = Course.find_by(id: params[:course_id])
    @unit = @course.units.find_by(id: params[:unit_id]) if @course.present?
    @language = Language.find(params[:language]) || current_user.unit_advances.languages.first
    @period = Period.find(params[:period]) || Period.default
    @snapshots = apply_scopes(UnitAdvance::Snapshot.with_user(current_user))
  end

  private

  def render_courses_select
    options = view_context.content_tag(:option, t(:all), { value: nil, data: { path: url_for } })
    Course.published_only.each do |course|
      path = url_for(course: course)
      parameters = { value: course.id, data: { path: path } }

      if @course.present? and course.id == @course.id
        parameters.merge!({ selected: 'selected' })
      end

      options << view_context.content_tag(:option, course.title, parameters)
    end

    view_context.select_tag 'course', options.html_safe, class: 'input-medium'.freeze
  end

  def render_units_select
    options = view_context.content_tag(:option, t(:all), { value: nil, data: { path: url_for } })

    if (@course)
      @course.units.published_only.each do |unit|
        path = url_for(unit: unit)
        parameters = { value: unit.id, data: { path: path } }

        if @unit.present? and unit.id == @unit.id
          parameters.merge!({ selected: 'selected' })
        end

        options << view_context.content_tag(:option, unit.title, parameters)
      end
    end

    view_context.select_tag 'unit', options.html_safe, class: 'input-small'.freeze
  end

  def render_languages_select
    options = view_context.content_tag(:option, t(:all), { value: nil, data: { path: url_for } })
    current_user.unit_advances.languages.each do |language|
      path = url_for(language: language)
      parameters = { value: language.slug, data: { path: path } }

      if @language.present? and language.id == @language.id
        parameters.merge!({ selected: 'selected' })
      end

      options << view_context.content_tag(:option, language.title, parameters)
    end

    view_context.select_tag 'language', options.html_safe, class: 'input-small'.freeze
  end

  def render_periods_select
    options = view_context.content_tag(:option, t(:all), { value: nil, data: { path: url_for } })
    Period.all.each do |period|
      path = url_for(period: period)
      parameters = { value: period.slug, data: { path: path } }

      if @period.present? and period.id == @period.id
        parameters.merge!({ selected: 'selected' })
      end

      options << view_context.content_tag(:option, period.title, parameters)
    end

    view_context.select_tag 'period', options.html_safe, class: 'input-small'.freeze
  end
end

