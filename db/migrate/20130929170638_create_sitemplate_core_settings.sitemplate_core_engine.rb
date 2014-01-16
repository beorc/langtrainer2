# This migration comes from sitemplate_core_engine (originally 20130909142319)
class CreateSitemplateCoreSettings < ActiveRecord::Migration
  def change
    create_table :sitemplate_core_settings do |t|
      t.string :key
      t.string :value
      t.string :category
      t.index [:key, :category], unique: true
      t.index :key
      t.index :category

      t.timestamps
    end
  end
end
