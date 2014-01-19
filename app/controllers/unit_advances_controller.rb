class UnitAdvancesController < ApplicationController
  respond_to :json
  before_filter :fetch_advance

  def check_answer
    render_markup_for(@stat)
  end

  def unit_advances
    render_markup_for(@stat)
  end

  def unit_advances
    render_markup_for(@stat)
  end

  def unit_advances
    render_markup_for(@stat)
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

  def render_markup_for(advances)
    markup = view_context.render partial: 'units/advance', object: advances
    render status: 200, json: { markup: markup }
  end
end
