class Step < ActiveRecord::Base
  validates :ru, :en, presence: true

  has_many :step_mappings, dependent: :destroy
  has_many :step_box_mappings, dependent: :destroy
  has_many :boxes, through: :step_box_mappings

  def template(language_slug)
    template = send("#{language_slug}_template") || shared_template
    return template.present? ? template : send(language_slug)
  end

  def regexp(language_slug)
    send("#{language_slug}_regexp")
  end

  def title
    ru
  end
end

