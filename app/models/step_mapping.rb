class StepMapping < ActiveRecord::Base
  validates :unit_id, :step_id, presence: true

  belongs_to :unit
  belongs_to :step

  scope :for_course, ->(course_id) { joins(:unit).where(course_id: course_id) }
  scope :ordered, -> { order(:position) }

  def self.from_language(language)
    where("from_#{language}" => true)
  end

  def self.to_language(language)
    where("to_#{language}" => true)
  end

  def self.shuffled
    scoped.sample(count)
  end
end

