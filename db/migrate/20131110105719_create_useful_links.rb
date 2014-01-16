class CreateUsefulLinks < ActiveRecord::Migration
  def up
    create_table :useful_links do |t|
      t.string :url
      t.string :source
    end

    UsefulLink.create_translation_table! title: :string, description: :string
  end

  def down
    drop_table :useful_links
    UsefulLink.drop_translation_table!
  end
end
