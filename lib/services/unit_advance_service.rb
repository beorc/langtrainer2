class UnitAdvanceService < Struct.new(:controller, :unit_advance, :params)

  private

  def current_step
    @current_step ||= Step.find(unit_advance.steps[unit_advance.current_step])
  end
end






