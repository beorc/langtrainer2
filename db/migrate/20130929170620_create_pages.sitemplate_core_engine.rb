# This migration comes from sitemplate_core_engine (originally 20111029161539)
class CreatePages < ActiveRecord::Migration
  def up
    create_table :pages do |t|
      t.string :title
      t.string :slug
      t.text :content
      t.timestamps
    end

    add_index :pages, :slug, unique: true
  end

  def down
    drop_table :pages
  end
end

