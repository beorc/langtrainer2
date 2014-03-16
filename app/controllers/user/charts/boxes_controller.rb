class User::Charts::BoxesController < User::Charts::BaseController

  def show
    super

    @chart = Charts::Boxes.new current_user,
                               @period,
                               @language,
                               @course,
                               @unit
    gon.data = @chart.data
  end
end

