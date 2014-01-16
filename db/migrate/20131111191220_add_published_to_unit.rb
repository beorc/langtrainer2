class AddPublishedToUnit < ActiveRecord::Migration
  def change
    add_column :units, :published, :boolean, default: false
  end
end
