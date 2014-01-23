class TrainingService < Struct.new(:controller, :unit_advance)

  def right_answer!
    unit_advance.right_answer!
    unit_advance.step_passed!
  end

  def wrong_answer!
    unit_advance.wrong_answer!
  end

  def next_step
    unit_advance.step_passed!
    next_step = fetch_next_step
    if next_step.present?
      controller.render_step(next_step)
    else
      unit_advance.revised!
      controller.render_step(next_step)
    end
  end

  def help_next_word
    unit_advance.word_helped!
  end

  def show_right_answer
    unit_advance.step_helped!
    unit_advance.step_passed!
  end

  private

  def fetch_next_step
    if unit_advance.revised?
      @next_step ||= fetch_step_from_boxes
    else
      return if unit_advance.steps.count == unit_advance.current_step
      @next_step ||= unit_advance.steps[unit_advance.current_step + 1]
    end
  end
end



