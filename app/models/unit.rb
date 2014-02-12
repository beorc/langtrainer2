class Unit < ActiveRecord::Base
  include HavingLatestContent

  def self.slug_validation_opts
    { presence: true,
      uniqueness: { scope: :course_id } }
  end

  permalink_for :title, as: :slug

  translates :title, :description

  validates :title, :slug, :course_id, presence: true

  belongs_to :course
  has_many :step_mappings, dependent: :destroy
  has_many :steps, through: :step_mappings
  has_one :latest_content, as: :owner, dependent: :destroy
  has_many :unit_advances, dependent: :destroy

  scope :published_only, -> { where(published: true) }

  def self.latest_contents
    LatestContent.where(owner_type: 'Unit', owner_id: published_only.pluck(:id))
  end
end

