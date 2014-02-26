class User < ActiveRecord::Base
  include UserConcerns::Base
  has_many :unit_advances, dependent: :destroy

  def self.devise_opts
    [:database_authenticatable, :registerable, :trackable, :recoverable, :rememberable, :confirmable, :validatable]
  end

  devise *devise_opts
  before_save *before_save_opts

  validates :username, uniqueness: true if :username?

  def has_assigned_language?
    language_id.present?
  end

  def language
    return Language.english if language_id.nil?
    Language.find(language_id)
  end

  def locale
    language.russian? ? :ru : :en
  end

  def title
    return username if username.present?
    email.split('@').first
  end
end

