class User::Charts::BoxesController < User::Charts::BaseController

  def show
    super
    @chart = Charts::Boxes.new @boxes
    gon.data = @chart.data
  end
end

