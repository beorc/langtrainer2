class Admin::UnitsController < Admin::ApplicationController
  include Admin::HavingLatestContent

  respond_to :html
  responders :flash

  def index
    respond_with @units = apply_scopes(Unit.all)
  end

  def show
    respond_with @unit = Unit.find(params[:id])
  end

  def new
    respond_with @unit = Unit.new
  end

  def create
    @unit = globalized { Unit.new(unit_params) }
    handle_latest_content(@unit)
    @unit.save
    respond_with @unit, location: [:admin, @unit]
  end

  def edit
    respond_with @unit = Unit.find(params[:id])
  end

  def update
    @unit = Unit.find(params[:id])
    globalized { @unit.update_attributes(unit_params) }
    handle_latest_content(@unit)
    @unit.latest_content.save
    respond_with @unit, location: [:admin, @unit]
  end

  def destroy
    @unit = Unit.find(params[:id])
    @unit.destroy
    respond_with @unit, location: admin_units_path
  end

  private

  def unit_params
    params.require(:unit).permit(*permitted_params)
  end

  def permitted_params
    [:title, :slug, :description, :random_steps_order, :free, :course_id, :published]
  end
end

