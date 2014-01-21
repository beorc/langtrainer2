class VerificationService < Struct.new(:controller, :unit_advance, :params)

  def verify!
    current_step = unit_advance.steps[unit_advance.current_step]
    right_answer = current_step.send(unit_advance.language.slug)
    answer = params[:answer]
    controller.right_answer if /#{answer}/.match(right_answer)
    controller.wrong_answer
  end
end





