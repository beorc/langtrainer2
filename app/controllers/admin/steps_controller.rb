class Admin::StepsController < Admin::ApplicationController
  respond_to :html
  responders :flash

  def index
    respond_with @steps = apply_scopes(Step.all)
  end

  def show
    respond_with @step = Step.find(params[:id])
  end

  def new
    respond_with @step = Step.new
  end

  def create
    respond_with @step = Step.create(step_params), location: [:admin, @step]
  end

  def edit
    respond_with @step = Step.find(params[:id])
  end

  def update
    @step = Step.find(params[:id])
    @step.update_attributes(step_params)
    respond_with @step, location: [:admin, @step]
  end

  def destroy
    @step = Step.find(params[:id])
    @step.destroy
    respond_with @step, location: admin_steps_path
  end

  private

  def step_params
    params.require(:step).permit(*permitted_params)
  end

  def permitted_params
    [:shared_template,
     :ru_template,
     :en_template,
     :es_template,
     :en,
     :en_regexp,
     :ru,
     :ru_regexp,
     :es,
     :es_regexp]
  end
end

