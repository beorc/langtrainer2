class User::Charts::AnswersController < User::Charts::BaseController
  def show
    super

    chart = ::Charts::Boxes.new @snapshots, @period
    gon.boxes = chart.data

    #chart = ::Charts::RightAnswers.new @snapshots, @period
    #gon.right_answers = chart.data

    #chart = ::Charts::WrongAnswers.new @snapshots, @period
    #gon.wrong_answers = chart.data
  end
end

