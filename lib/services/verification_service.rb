class VerificationService < UnitAdvanceService

  def verify
    answer = params[:answer]
    matched = false

    regexp = current_step.regexp(unit_advance.language.slug)

    if regexp.present?
      matched = /#{regexp}/.match(answer)
    else
      right_answer = Regexp.escape current_step.send(unit_advance.language.slug)
      matched = /#{right_answer}/.match(answer)
    end

    if matched
      controller.right_answer
    else
      controller.wrong_answer
    end
  end
end
