class User::DashboardController < ApplicationController
  layout :determine_layout

  private

  def determine_layout
    return 'user_profile' if user_signed_in?
    'application'
  end
end

