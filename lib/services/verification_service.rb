class VerificationService < Struct.new(:controller, :unit_advance, :params)

  def verify!
    right_answer = current_step.send(unit_advance.language.slug)
    answer = params[:answer]
    if /#{answer}/.match(right_answer)
      controller.right_answer
    else
      controller.wrong_answer
    end
  end
end





