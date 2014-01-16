class AddShortToPages < ActiveRecord::Migration
  def change
    add_column :pages, :short, :text
  end
end
