class UnitAdvanceService < Struct.new(:controller, :unit_advance, :session, :params)

  private

  def current_step
    @current_step ||= unit_advance.steps[unit_advance.current_step]
  end
end






