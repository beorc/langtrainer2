# This migration comes from sitemplate_core_engine (originally 20130802104812)
class AddTrackableToUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      ## Trackable
      t.integer  :sign_in_count, :default => 0
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip
    end
  end
end
