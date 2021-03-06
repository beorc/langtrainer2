class LatestContent < ActiveRecord::Base
  translates :title, :description

  validates :title, :owner_id, :released_at, presence: true

  belongs_to :owner, polymorphic: true

  scope :order_by_date, -> { order('released_at DESC') }

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

  def full_title
    return owner.latest_content.title if owner.is_a?(Course)
    return "#{owner.course.latest_content.title}: #{title}" if owner.is_a?(Unit)
    title
  end

  private

  def set_released_at
    self.released_at ||= DateTime.now
  end
end


