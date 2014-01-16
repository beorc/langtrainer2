class CreateUnits < ActiveRecord::Migration
  def up
    create_table :units do |t|
      t.string :slug
      t.boolean :random_steps_order, default: false
      t.boolean :free, default: true
      t.references :course, index: true

      t.index [:slug, :course_id], unique: true
    end

    Unit.create_translation_table! title: :string, description: :text
  end

  def down
    drop_table :units
    Unit.drop_translation_table!
  end
end
