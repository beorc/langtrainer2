class User::Charts::AnswersController < User::Charts::BaseController
  def show
    super

    chart = ::Charts::Answers.new @snapshots, @period
    gon.boxes = chart.data
  end
end

