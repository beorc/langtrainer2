class User::Charts::HintsController < User::Charts::BaseController
  def show
    super

    chart = ::Charts::StepsHelped.new @snapshots
    gon.steps_helped = chart.data

    chart = ::Charts::WordsHelped.new @snapshots
    gon.words_helped = chart.data
  end
end

