class LatestContentsController < ApplicationController

  def index
    @latest_contents = LatestContent.
      where(owner_type: 'Unit',
            owner_id: Unit.published_only.pluck(:id)).
      group(:owner_id).
      order_by_date
  end
end

