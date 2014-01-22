class BoxesService < UnitAdvanceService

  def right_answer!
    next_box = fetch_user_boxes(Box.for_course(@course.id)).find_by(number: number + 1)
    if next_box.present?
      mapping = @step.step_box_mappings.where(user_id: current_user.id,
                                              box_id: current_step_box.id)
      mapping.box = next_box
      mapping.save!
    end
    render nothing: true
  end

  def wrong_answer!
    first_box = current_user.boxes.for_course(@course.id).find_by(number: 0)
    if first_box.present?
      mapping = @step.step_box_mappings.where(user_id: current_user.id,
                                              box_id: current_step_box.id)
      mapping.box = first_box
      mapping.save!
    end
    render nothing: true
  end

  private

  def fetch_user_boxes(boxes)
    if unit_advance.user.present?
      boxes.for_user(unit_advance.user)
    else
      boxes.for_session(unit_advance.session_token)
    end
  end

  def current_step_box
    fetch_user_boxes(current_step.boxes.for_course(unit_advance.course))
  end
end

