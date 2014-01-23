class UnitAdvancesController < ApplicationController
  respond_to :json
  before_filter :fetch_advance

  def verify_answer
    VerificationService.new(self, @advance, params).verify!
  end

  def next_step
    TrainingService.new(self, @advance).next_step
  end

  def help_next_word
    TrainingService.new(self, @advance).help_next_word
  end

  def show_right_answer
    TrainingService.new(self, @advance).show_right_answer
  end

  def right_answer
    BoxesService.new(self, @advance).right_answer!
    TrainingService.new(self, @advance).right_answer!
    RevisionService.new(self, @advance, params).right_answer!
  end

  def wrong_answer
    BoxesService.new(self, @advance).wrong_answer!
    TrainingService.new(self, @advance).wrong_answer!
    RevisionService.new(self, @advance, params).wrong_answer!
  end

  def render_step(step)
    native_slug = native_language.slug.to_sym
    target_slug = @advance.language.slug.to_sym

    render json: { step: { id: step.id,
                           template: step.template,
                           native_slug => step.send(native_slug),
                           target_slug => step.send(target_slug) } }
  end

  private

  def fetch_advance
    options = { date: Date.today,
                unit_id: params[:unit_id],
                language_id: params[:language_id] }

    @advance = fetch_advances(options).first_or_create
  end
end
