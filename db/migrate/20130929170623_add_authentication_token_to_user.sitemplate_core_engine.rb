# This migration comes from sitemplate_core_engine (originally 20121018142558)
class AddAuthenticationTokenToUser < ActiveRecord::Migration
  def change
    unless column_exists? :users, :authentication_token
      add_column :users, :authentication_token, :string
      add_index :users, :authentication_token, unique: true
    end
  end
end
