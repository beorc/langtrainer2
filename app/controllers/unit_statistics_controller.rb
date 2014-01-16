class UnitStatisticsController < ApplicationController
  respond_to :json
  before_filter :check_for_signed_in
  before_filter :fetch_stat

  def step_passed
    @stat.step_passed!
    render_markup_for(@stat)
  end

  def word_helped
    @stat.word_helped!
    render_markup_for(@stat)
  end

  def step_helped
    @stat.step_helped!
    render_markup_for(@stat)
  end

  def right_answer
    @stat.right_answer!
    render_markup_for(@stat)
  end

  def wrong_answer
    @stat.wrong_answer!
    render_markup_for(@stat)
  end

  private

  def check_for_signed_in
    render(status: 401, nothing: true) unless user_signed_in?
  end

  def fetch_stat
    @stat = UnitStatistic.find(params[:unit_statistic_id])
  end

  def render_markup_for(statistics)
    markup = view_context.render partial: 'units/statistics', object: statistics
    render status: 200, json: { markup: markup }
  end
end
