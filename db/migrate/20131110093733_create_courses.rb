class CreateCourses < ActiveRecord::Migration
  def up
    create_table :courses do |t|
      t.string :slug

      t.index :slug, unique: true
    end

    Course.create_translation_table! title: :string, short: :text, description: :text
  end

  def down
    drop_table :courses
    Course.drop_translation_table!
  end
end
