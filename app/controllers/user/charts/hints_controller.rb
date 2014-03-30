class User::Charts::HintsController < User::Charts::BaseController
  def show
    super

    chart = ::Charts::Hints.new @snapshots, @period
    gon.hints = chart.data
  end
end

