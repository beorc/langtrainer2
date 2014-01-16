# This migration comes from sitemplate_core_engine (originally 20130711093014)
class RemovePageCategoryIdFromPages < ActiveRecord::Migration
  def change
    remove_column :pages, :page_category_id
  end
end
