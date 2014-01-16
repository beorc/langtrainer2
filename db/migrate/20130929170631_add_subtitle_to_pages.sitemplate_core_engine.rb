# This migration comes from sitemplate_core_engine (originally 20130524123636)
class AddSubtitleToPages < ActiveRecord::Migration
  def change
    add_column :pages, :subtitle, :string
  end
end
