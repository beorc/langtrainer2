class UsefulLink < ActiveRecord::Base
  translates :title, :description

  validates :url, :source, :title, presence: true, uniqueness: true
end


