class Box < ActiveRecord::Base
  belongs_to :unit_advance
  has_many :step_box_mappings, dependent: :destroy
  has_many :steps, through: :step_box_mappings

  validates :unit_advance, presence: true

  scope :ordered_by_number, -> { order(:number) }
  scope :for_number, ->(number) { where(number: number) }
  scope :with_step, ->(step) { joins(:steps).where('step_box_mappings.step_id = ?', step.id) }

  def random_step
    steps[rand(0..steps.count)]
  end

  def next_box
    unit_advance.boxes.find_by(number: number + 1)
  end

  def first_box
    unit_advance.boxes.find_by(number: number + 1)
  end
end

