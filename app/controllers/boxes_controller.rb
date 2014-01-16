class BoxesController < ApplicationController
  respond_to :json
  before_filter :check_for_signed_in
  before_filter :fetch_step_and_course

  def box_up
    current_box = @step.boxes.for_course(@course.id).for_user(current_user)
    next_box = current_user.boxes.for_course(@course.id).find_by(number: number + 1)
    if next_box.present?
      mapping = @step.step_box_mappings.where(user_id: current_user.id,
                                              box_id: current_box.id)
      mapping.box = next_box
      mapping.save!
    end
    render nothing: true
  end

  def box_down
    current_box = @step.boxes.for_course(@course.id).for_user(current_user)
    first_box = current_user.boxes.for_course(@course.id).find_by(number: 0)
    if first_box.present?
      mapping = @step.step_box_mappings.where(user_id: current_user.id,
                                              box_id: current_box.id)
      mapping.box = first_box
      mapping.save!
    end
    render nothing: true
  end

  private

  def check_for_signed_in
    render(status: 401, nothing: true) unless user_signed_in?
  end

  def fetch_step_and_course
    @step = Step.find(params[:step_id])
    @course = Course.find(params[:course_id])
  end
end

