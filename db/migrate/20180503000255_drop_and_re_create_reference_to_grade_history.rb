class DropAndReCreateReferenceToGradeHistory < ActiveRecord::Migration[5.2]
  def up
    remove_reference :aspiration_high_school_histories, :grade_history
    add_reference :aspiration_high_school_histories, :grade_history, null: true, index: true
    remove_reference :aspiration_university_histories, :grade_history
    add_reference :aspiration_university_histories, :grade_history, null: true, index: true
  end
  def down
    remove_reference :aspiration_high_school_histories, :grade_history
    remove_reference :aspiration_university_histories, :grade_history
    add_reference :aspiration_high_school_histories, :grade_history, null: false, foreign_key: true, index: true
    add_reference :aspiration_university_histories, :grade_history, null: false, foreign_key: true, index: true
  end
end
