class UnitsController < ApplicationController

  def show
    @unit = Unit.find(params[:id])
    @course = Course.find(params[:course_id])
    @language = Language.find params[:language_id]

    @steps = fetch_steps

    if user_signed_in?
      @unit_statistic = UnitStatistic.where(date: Date.today,
                                            user_id: current_user.id,
                                            unit_id: @unit.id,
                                            language_id: params[:language_id]).first_or_create
      gon.unit_statistic_id = @unit_statistic.id
      gon.course_id = @course.id

      gon.step_passed_path = step_passed_path
      gon.word_helped_path = word_helped_path
      gon.step_helped_path = step_helped_path
      gon.right_answer_path = right_answer_path
      gon.wrong_answer_path = wrong_answer_path

      gon.box_up = box_up_path
      gon.box_down = box_down_path
    end
  end

  private

  def fetch_steps_from_previous_units
    fetch_steps_from_boxes(@unit.steps.count / 2)
  end

  def fetch_steps_from_boxes(number)
    steps = []
    number.times do
      rand = rand(0..100)

      threshold = 0
      step = nil
      boxes.ordered_by_number.each do |box|
        box_probability = Langtrainer2.config.boxes_probabilities[box.number]
        threshold += box_probability
        if box.steps.any?
          if rand <= threshold
            step = box.fetch_step
            break
          end
        end
      end
      if step.nil?
        boxes.ordered_by_number.each do |box|
          if box.steps.any?
            step = box.fetch_step
            break
          end
        end
      end
      steps << step unless step.nil?
    end
    steps
  end

  def fetch_first_time_steps
    step_mappings = @unit.step_mappings.from_language(@language.slug).
                                        to_language(native_language.slug)
    step_mappings = @unit.random_steps_order? ? step_mappings.shuffled : step_mappings.ordered
    step_mappings.map(&:step)
  end

  def fetch_steps
    if user_signed_in?
      init_boxes
      steps = fetch_steps_from_boxes(@unit.steps.count)
      fetch_steps_from_previous_units.concat(steps) if steps.any?
    else
      steps = fetch_first_time_steps
    end

    steps
  end

  def init_boxes
    boxes = @course.boxes.for_user(current_user)
    return boxes if boxes.any?
    counter = 0
    Langtrainer2.config.boxes_number.times do
      @course.boxes.create user: current_user, number: counter
      counter += 1
    end
    boxes = @course.boxes.for_user(current_user)
    default_box = boxes.ordered_by_number.first
    default_box.steps = fetch_first_time_steps
    default_box.save!

    boxes
  end

  def boxes
    boxes = @course.boxes.for_user(current_user)
    init_boxes if boxes.empty?
    boxes
  end
end

