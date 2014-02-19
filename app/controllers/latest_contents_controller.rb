class LatestContentsController < ApplicationController
  has_scope :page, default: 1

  def index
    @latest_contents = apply_scopes(LatestContent.
      where(owner_type: 'Unit',
            owner_id: Unit.published_only.pluck(:id)).
            uniq.
            order_by_date)
  end
end

