class UnitsController < ApplicationController

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
end

