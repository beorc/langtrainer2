class Page < ActiveRecord::Base
  include SitemplateCore::HavingMetatags

  translates :title, :short, :content

  permalink_for :title, as: :slug

  mount_uploader :title_image, PagesImageUploader
  validates :title, presence: true

  scope :by_date, -> { order('created_at DESC') }
end

