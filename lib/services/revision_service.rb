class RevisionService < Struct.new(:unit_advance)

  def right_answer!
    unit_advance.step_revised!
  end
end



