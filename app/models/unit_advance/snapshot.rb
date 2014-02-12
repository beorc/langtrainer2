class UnitAdvance::Snapshot < ActiveRecord::Base
  belongs_to :unit_advance
  validates :unit_advance_id, :date, presence: true
  validates :date, uniqueness: { scope: :unit_advance_id }

  def self.table_name_prefix
    'unit_advance_'
  end
end
