module HavingLatestContent
  extend ActiveSupport::Concern

  included do
    has_one :latest_content, as: :owner, dependent: :destroy
  end
end
