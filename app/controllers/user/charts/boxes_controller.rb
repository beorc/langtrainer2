class User::Charts::BoxesController < User::Charts::BaseController
  def show
    super

    boxes = ::Charts::Boxes.new @snapshots, @period
    gon.boxes = boxes.data
  end
end

