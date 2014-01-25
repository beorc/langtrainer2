class StepBoxMapping < ActiveRecord::Base
  validates :box_id, :step_id, presence: true

  belongs_to :box
  belongs_to :step
end


