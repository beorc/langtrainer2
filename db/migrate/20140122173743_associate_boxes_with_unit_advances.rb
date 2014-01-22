class AssociateBoxesWithUnitAdvances < ActiveRecord::Migration
  def change
    remove_reference :boxes, :user
    add_reference :boxes, :unit_advance, index: true

    remove_reference :step_box_mappings, :user
    add_reference :step_box_mappings, :unit_advance, index: true
  end
end
