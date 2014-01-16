class Admin::UsefulLinksController < Admin::ApplicationController
  respond_to :html
  responders :flash

  def index
    respond_with @useful_links = apply_scopes(UsefulLink.all)
  end

  def show
    respond_with @useful_link = UsefulLink.find(params[:id])
  end

  def new
    respond_with @useful_link = UsefulLink.new
  end

  def create
    respond_with @useful_link = globalized { UsefulLink.create(useful_link_params) }, location: [:admin, @useful_link]
  end

  def edit
    respond_with @useful_link = UsefulLink.find(params[:id])
  end

  def update
    @useful_link = UsefulLink.find(params[:id])
    globalized { @useful_link.update_attributes(useful_link_params) }
    respond_with @useful_link, location: [:admin, @useful_link]
  end

  def destroy
    @useful_link = UsefulLink.find(params[:id])
    @useful_link.destroy
    respond_with @useful_link, location: admin_useful_links_path
  end

  private

  def useful_link_params
    params.require(:useful_link).permit(*permitted_params)
  end

  def permitted_params
    [:title, :url, :source, :description]
  end
end

