class Admin::PagesController < Admin::ApplicationController
  include SitemplateCore::Admin::PagesControllerBase

  def permitted_params
    super << :short
  end
end


