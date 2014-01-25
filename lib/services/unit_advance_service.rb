class UnitAdvanceService < Struct.new(:controller, :unit_advance, :params)

  private

  def current_step
    raise unit_advance.current_step.inspect
    @current_step ||= Step.find(unit_advance.steps[unit_advance.current_step])
  end
end






