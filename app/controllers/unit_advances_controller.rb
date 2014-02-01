class UnitAdvancesController < ApplicationController
  respond_to :json
  before_filter :fetch_unit_advance

  def verify_answer
    VerificationService.new(self, @unit_advance, params).verify
  end

  def next_step
    TrainingService.new(self, @unit_advance).next_step
  end

  def help_next_word
    TrainingService.new(self, @unit_advance).help_next_word
  end

  def show_right_answer
    TrainingService.new(self, @unit_advance).show_right_answer
  end

  def right_answer
    BoxesService.new(self, @unit_advance).right_answer!
    RevisionService.new(@unit_advance).right_answer!
    TrainingService.new(self, @unit_advance).right_answer!
    render json: { correct: true, comment: t('units.show.comments.correct') }
  end

  def wrong_answer
    BoxesService.new(self, @unit_advance).wrong_answer!
    TrainingService.new(self, @unit_advance).wrong_answer!
    render json: { correct: false, comment: t('units.show.comments.wrong') }
  end

  def render_step(step)
    markup = view_context.render partial: 'units/step', object: step
    render json: { markup: markup }
  end

  def render_nothing
    render nothing: true
  end

  private

  def fetch_unit_advance
    unit = Unit.find(params[:unit])
    language = Language.find(params[:language])
    options = { date: Date.today,
                unit_id: unit.id,
                language_id: language.id,
                native_language_id: native_language.id }

    @unit_advance = fetch_advances(options).first
    raise "Advance not found! (#{options.inspect})" if @unit_advance.nil?
  end
end
