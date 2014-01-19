class UnitsController < ApplicationController

  def show
    @unit = Unit.find(params[:id])
    @course = Course.find(params[:course_id])
    @language = Language.find params[:language_id]

    @unit_advance = UnitAdvance.where(date: Date.today,
                                          user_id: current_user.id,
                                          unit_id: @unit.id,
                                          language_id: params[:language_id]).first_or_create

    gon.unit = @unit.slug
    gon.language = @language.slug
    gon.current_step = @unit_advance.current_step

    gon.check_answer_path = check_answer_path
    gon.next_step_path = next_step_path
    gon.help_next_word_path = help_next_word_path
    gon.show_right_answer_path = show_right_answer_path
  end
end

