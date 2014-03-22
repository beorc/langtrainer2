class User::Charts::BoxesController < User::Charts::BaseController

  def show
    super
    @chart = ::Charts::Boxes.new @snapshots.boxes
    gon.data = @chart.data
  end
end

