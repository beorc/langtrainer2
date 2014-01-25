class BoxesService < UnitAdvanceService

  def right_answer!
    if next_box.present?
      mapping = current_step_box.step_box_mappings.where(step_id: current_step.id).first
      mapping.box = next_box
      mapping.save!
    end
  end

  def wrong_answer!
    if first_box.present?
      mapping = current_step_box.step_box_mappings.where(step_id: current_step.id).first
      mapping.box = first_box
      mapping.save!
    end
  end

  private

  def first_box
    @first_box ||= unit_advance.boxes.find_by(number: 0)
  end

  def next_box
    @next_box ||= current_step_box.next_box
  end

  def current_step_box
    @current_step_box ||= unit_advance.boxes.with_step(current_step).first
  end

  def current_step_mapping
    @current_step_mapping ||= current_step_box.step_box_mappings.where(step_id: current_step.id)
  end
end

