# This migration comes from sitemplate_core_engine (originally 20130320151217)
class AddUsernameToAuthentications < ActiveRecord::Migration
  def change
    add_column :authentications, :username, :string
  end
end
