# This migration comes from sitemplate_core_engine (originally 20130711111533)
class RemoveSubtitleFromPages < ActiveRecord::Migration
  def change
    remove_column :pages, :subtitle
  end
end
