class User::DashboardController < ApplicationController
  layout :determine_layout
  before_filter :fetch_user

  def show
    @courses = @user.courses
    gon.answers = {}
    @courses.each do |course|
      snapshots = course.snapshots.with_user(@user)

      chart = ::Charts::Answers.new snapshots, Period.find(Period::OneYear), { month: 1 }
      gon.answers[course.id] = chart.data
    end

  end

  private

  def determine_layout
    return 'user_profile' if user_signed_in?
    'application'
  end

  def fetch_user
    @user = current_user || User.find_by_username(params[:username])
  end
end

