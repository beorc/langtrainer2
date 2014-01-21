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

  private

  def fetch_advance
    options = { date: Date.today,
                unit_id: params[:unit_id],
                step_number: params[:step_number],
                language_id: params[:language_id] }

    if user_signed_in?
      options[:user_id] = current_user.id
    else
      session[:unit_advance_token] = UnitAdvance.generate_session_token if session[:unit_advance_token].blank?
      options[:session_token] = session[:unit_advance_token]
    end

    @advance = UnitAdvance.where(options).first_or_create
  end
end
