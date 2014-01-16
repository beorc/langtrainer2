class Admin::StepMappingsController < Admin::ApplicationController
  respond_to :html
  responders :flash

  before_filter :fetch_course_and_unit, only: [:new, :edit, :index]

  def index
    respond_with @step_mappings = apply_scopes(@course.step_mappings)
  end

  def show
    respond_with @step_mapping = StepMapping.find(params[:id])
  end

  def new
    respond_with @step_mapping = StepMapping.new
  end

  def create
    respond_with @step_mapping = StepMapping.create(step_mapping_params), location: [:admin, @step_mapping]
  end

  def edit
    respond_with @step_mapping = StepMapping.find(params[:id])
  end

  def update
    @step_mapping = StepMapping.find(params[:id])
    @step_mapping.update_attributes(step_mapping_params)
    respond_with @step_mapping, location: [:admin, @step_mapping]
  end

  def destroy
    @step_mapping = StepMapping.find(params[:id])
    @step_mapping.destroy
    respond_with @step_mapping, location: admin_step_mappings_path
  end

  def default_url_options
    { course: @course, unit: @unit }.merge(super)
  end

  private

  def step_mapping_params
    params.require(:step_mapping).permit(*permitted_params)
  end

  def permitted_params
    [:unit_id,
     :step_id,
     :position,
     :from_en,
     :to_en,
     :from_ru,
     :to_ru,
     :from_es,
     :to_es]
  end

  def fetch_course_and_unit
    @course = Course.find_by(id: params[:course]) || Course.first
    @unit = Unit.find_by(id: params[:unit]) || Unit.first
  end
end

