class AssociateBoxesWithUnitAdvances < ActiveRecord::Migration
  def change
    remove_reference :boxes, :user
    remove_reference :boxes, :course
    add_reference :boxes, :unit_advance, index: true
  end
end
