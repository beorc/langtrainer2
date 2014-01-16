# This migration comes from sitemplate_core_engine (originally 20121227120725)
class AddCategoryToPages < ActiveRecord::Migration
  def change
    add_column :pages, :page_category_id, :integer
    add_index :pages, :page_category_id
  end
end
