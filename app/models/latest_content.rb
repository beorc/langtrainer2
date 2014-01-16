class LatestContent < ActiveRecord::Base
  translates :title, :description

  validates :title, :owner_id, :released_at, presence: true

  belongs_to :owner, polymorphic: true

  scope :by_date, -> { order('released_at DESC') }

  before_create :set_released_at

  delegate :published?, to: :owner

  def type
    return owner.class.model_name.human.capitalize
  end

  def course
    return owner if owner.is_a?(Course)
    return owner.course if owner.is_a?(Unit)
  end

  def unit
    return owner.units.published_only.first if owner.is_a?(Course)
    return owner if owner.is_a?(Unit)
  end

  private

  def set_released_at
    self.released_at ||= DateTime.now
  end
end


