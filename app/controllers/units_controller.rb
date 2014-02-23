class UnitsController < ApplicationController
  helper_method :render_courses_select,
                :render_units_select

  def show
    @unit = Unit.find(params[:id])
    @course = Course.find(params[:course_id])
    @language = Language.find params[:language_id]

    options = { unit_id: @unit.id,
                language_id: params[:language_id],
                native_language_id: native_language.id }

    @unit_advance = fetch_advances(options).first_or_create!
    @step = @unit_advance.fetch_step

    gon.unit = @unit.slug
    gon.language = @language.slug

    gon.verify_answer_path = verify_answer_path
    gon.next_step_path = next_step_path
    gon.help_next_word_path = help_next_word_path
    gon.show_right_answer_path = show_right_answer_path
  end

  private

  def render_courses_select
    options = ''
    Course.published_only.each do |course|
      path = language_course_unit_path(@language, course, @course.units.published_only.first)
      parameters = { value: course.id, data: { path: path } }

      if @course.present? and course.id == @course.id
        parameters.merge!({ selected: 'selected' })
      end

      options << view_context.content_tag(:option, course.title, parameters)
    end

    view_context.select_tag 'course', options.html_safe
  end

  def render_units_select
    options = ''
    @course.units.published_only.each do |unit|
      path = language_course_unit_path(@language, @course, unit)
      parameters = { value: unit.id, data: { path: path } }

      if @unit.present? and unit.id == @unit.id
        parameters.merge!({ selected: 'selected' })
      end

      options << view_context.content_tag(:option, unit.title, parameters)
    end

    view_context.select_tag 'unit', options.html_safe
  end
end

