class Course < ActiveRecord::Base
  include HavingLatestContent

  permalink_for :title, as: :slug

  translates :title, :short, :description

  validates :title, :slug, presence: true
  validates :slug, uniqueness: true

  has_many :units
  has_many :step_mappings, through: :units
  has_many :steps, through: :step_mappings
  has_many :boxes

  scope :published_only, -> { where(published: true) }
end
