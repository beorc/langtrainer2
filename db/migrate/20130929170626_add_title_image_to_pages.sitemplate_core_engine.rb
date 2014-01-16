# This migration comes from sitemplate_core_engine (originally 20121227111141)
class AddTitleImageToPages < ActiveRecord::Migration
  def change
    add_column :pages, :title_image, :string
  end
end
