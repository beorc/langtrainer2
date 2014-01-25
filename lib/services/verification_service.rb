class VerificationService < UnitAdvanceService

  def verify
    right_answer = current_step.send(unit_advance.language.slug)
    answer = params[:answer]
    matched = false

    regexp = current_step.regexp(unit_advance.language.slug)

    if regexp.present?
      matched = /#{regexp}/.match(answer)
    else
      matched = /#{answer}/.match(right_answer)
    end

    if matched
      controller.right_answer
    else
      controller.wrong_answer
    end
  end
end
