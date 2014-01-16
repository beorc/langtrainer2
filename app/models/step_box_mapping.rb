class StepBoxMapping < ActiveRecord::Base
  validates :box_id, :step_id, presence: true

  belongs_to :box
  belongs_to :step

  scope :for_course, ->(course_id) { joins(:box).where(course_id: course_id) }
end


