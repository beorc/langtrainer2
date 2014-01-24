class UnitAdvancesController < ApplicationController
  respond_to :json
  before_filter :fetch_advance

  def verify_answer
    VerificationService.new(self, @advance, params).verify
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
    RevisionService.new(@advance).right_answer!
    TrainingService.new(self, @advance).right_answer!
    render json: { correct: true }
  end

  def wrong_answer
    BoxesService.new(self, @advance).wrong_answer!
    TrainingService.new(self, @advance).wrong_answer!
    render json: { correct: false }
  end

  def render_step(step)
    markup = view_context.render partial: 'units/step', object: step
    render json: { markup: markup }
  end

  private

  def fetch_advance
    options = { date: Date.today,
                unit_id: params[:unit_id],
                language_id: params[:language_id] }

    @advance = fetch_advances(options).first_or_create
  end
end
