class UnitAdvance < ActiveRecord::Base
  validates :steps, :language_id, presence: true
  validates :date, uniqueness: { scope: [:user_id, :unit_id, :language_id] }
  validates :session_token, presence: true, unless: :user_id?
  validates :user_id, presence: true, unless: :session_token?

  belongs_to :user
  belongs_to :unit
  has_many :boxes, dependent: :destroy

  serialize :steps, Array

  before_validate :ensure_steps

  def self.generate_session_token
    loop do
      token = SecureRandom.base64(15).tr('+/=lIO0', 'pqrsxyz')
      break token if UnitAdvance.where(session_token: token).empty?
    end
  end

  def language
    Language.find(language_id)
  end

  def step_passed!
    self.steps_passed += 1
    save!
  end

  def word_helped!
    self.words_helped += 1
    save!
  end

  def step_helped!
    self.steps_helped += 1
    save!
  end

  def right_answer!
    self.right_answers += 1
    save!
  end

  def wrong_answer!
    self.wrong_answers += 1
    save!
  end

  private

  def ensure_steps
    return steps if steps.present?
    step_mappings = unit.step_mappings.from_language(language.slug).
                                        to_language(native_language.slug)
    step_mappings = @unit.random_steps_order? ? step_mappings.shuffled : step_mappings.ordered
    steps = step_mappings.map(&:step).map(&:id)
  end

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
    boxes = @course.boxes.for_user(user)
    return boxes if boxes.any?
    counter = 0
    Langtrainer2.config.boxes_number.times do
      @course.boxes.create unit_advance: self, number: counter
      counter += 1
    end
    boxes = @course.boxes.for_user(user)
    default_box = boxes.ordered_by_number.first
    default_box.steps = fetch_first_time_steps
    default_box.save!

    boxes
  end

  def boxes
    boxes = @course.boxes.for_user(user)
    init_boxes if boxes.empty?
    boxes
  end
end
