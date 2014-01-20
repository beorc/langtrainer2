class BoxesService < Struct.new(:controller, :unit_advance)

  def right_answer!
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

  def wrong_answer!
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
end


