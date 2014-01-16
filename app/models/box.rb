class Box < ActiveRecord::Base
  belongs_to :course
  belongs_to :user
  has_many :step_box_mappings, dependent: :destroy
  has_many :steps, through: :step_box_mappings

  scope :ordered_by_number, -> { order(:number) }
  scope :for_user, ->(user) { where(user_id: user.id) }
  scope :for_number, ->(number) { where(number: number) }
  scope :for_course, ->(course) { where(course_id: course.id) }

  def fetch_step
    steps[rand(0..steps.count)]
  end

  def next_box
    user.boxes.find_by(number: number + 1)
  end

  def first_box
    user.boxes.find_by(number: number + 1)
  end
end

