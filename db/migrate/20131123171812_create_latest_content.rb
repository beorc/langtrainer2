class CreateLatestContent < ActiveRecord::Migration
  def up
    create_table :latest_contents do |t|
      t.references :owner, polymorphic: true, index: true
      t.datetime :released_at
      t.index :released_at
    end

    LatestContent.create_translation_table! title: :string, description: :text
  end

  def down
    drop_table :latest_contents
    LatestContent.drop_translation_table!
  end
end
