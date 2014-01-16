class Admin::CoursesController < Admin::ApplicationController
  include Admin::HavingLatestContent

  respond_to :html
  responders :flash

  def index
    respond_with @courses = apply_scopes(Course.all)
  end

  def show
    @course = Course.find(params[:id])
    respond_with  @course
  end

  def new
    respond_with @course = Course.new
  end

  def create
    @course = globalized { Course.new(course_params) }
    handle_latest_content(@course)
    @course.save
    respond_with @course, location: [:admin, @course]
  end

  def edit
    respond_with @course = Course.find(params[:id])
  end

  def update
    @course = Course.find(params[:id])
    globalized { @course.update_attributes(course_params) }
    handle_latest_content(@course)
    @course.latest_content.save
    respond_with @course, location: [:admin, @course]
  end

  def destroy
    @course = Course.find(params[:id])
    @course.destroy
    respond_with @course, location: admin_courses_path
  end

  private

  def course_params
    params.require(:course).permit(*permitted_params)
  end

  def permitted_params
    [:title, :slug, :short, :description, :published]
  end
end

