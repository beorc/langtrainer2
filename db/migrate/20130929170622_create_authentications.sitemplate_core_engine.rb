# This migration comes from sitemplate_core_engine (originally 20121018083008)
class CreateAuthentications < ActiveRecord::Migration
  def change
    create_table :authentications do |t|
      t.integer :user_id
      t.string :provider
      t.string :uid

      t.timestamps
    end

    add_index :authentications, :user_id
  end
end
