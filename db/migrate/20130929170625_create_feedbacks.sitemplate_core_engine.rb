# This migration comes from sitemplate_core_engine (originally 20121205083809)
class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.text :message
      t.string :email
      t.string :phone
      t.string :name

      t.timestamps
    end
  end
end
