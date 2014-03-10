class User < ActiveRecord::Base
  include UserConcerns::Base
  has_many :unit_advances, dependent: :destroy

  def self.devise_opts
    [:database_authenticatable, :registerable, :trackable, :recoverable, :rememberable, :confirmable, :validatable]
  end

  devise *devise_opts
  before_save *before_save_opts
  before_save :ensure_username

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
    username
  end

  private

  def ensure_username
    return if username.present?
    username = email.split('@').first
  end
end

