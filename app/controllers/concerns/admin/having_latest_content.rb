module Admin::HavingLatestContent
  extend ActiveSupport::Concern

  def handle_latest_content(resource)
    if resource.latest_content.present?
      @latest_content = resource.latest_content
      if params['latest_content/delete'] == '1'
        resource.latest_content.destroy
      else
        apply_last_content_changes(@latest_content)
      end
    else
      @latest_content = resource.build_latest_content
      apply_last_content_changes(@latest_content)
    end
  end

  def apply_last_content_changes(latest_content)
    [:title, :description].each do |name|
      value = params["latest_content/#{name}"]
      if value.present? and value != latest_content.send(name)
        latest_content.send("#{name}=", value)
      end
    end

    released_at = params['latest_content/released_at']
    value = DateTime.civil released_at[:year].to_i,
                           released_at[:month].to_i,
                           released_at[:day].to_i,
                           released_at[:hour].to_i,
                           released_at[:minute].to_i

    if value.present? and value != latest_content.released_at
      latest_content.released_at = value
    end
    latest_content
  end
end

