class User::Charts::HintsController < User::Charts::BaseController
  def show
    super

    chart = ::Charts::Hints.new @snapshots, @period
    gon.boxes = chart.data
  end
end

