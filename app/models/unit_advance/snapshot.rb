class UnitAdvance::Snapshot < ActiveRecord::Base
  belongs_to :unit_advance
  has_one :unit, through: :unit_advance
  has_many :boxes, through: :unit_advance
  validates :unit_advance_id, :date, presence: true
  validates :date, uniqueness: { scope: :unit_advance_id }

  scope :with_user, ->(user) { joins(:unit_advance).where('unit_advances.user_id = ?', user.id) }
  scope :with_course, ->(course) { joins(:unit).where('units.course_id = ?', course.id) }
  scope :with_unit, ->(unit) { joins(:unit).where('units.id = ?', unit.id) }
  scope :with_language, ->(language) { joins(:unit_advances).where('unit_advances.language_id = ?', language.id) }
  scope :with_period, ->(period) { where('date = ?', period.start_date) }
  scope :for_date, ->(date) { where(date: date) }

  def self.table_name_prefix
    'unit_advance_'
  end

  def self.boxes
    ids = pluck(:unit_advance_id)
    Box.where(::Box.arel_table[:unit_advance_id].in ids)
  end
end
