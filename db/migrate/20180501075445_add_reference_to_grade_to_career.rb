class AddReferenceToGradeToCareer < ActiveRecord::Migration[5.2]
  def change
    add_reference :career_decisions_histories,:grade_history, null: true, index: true
    add_column :career_decisions_histories, :revision, :integer, null: false
    add_index :career_decisions_histories, [:user_id, :dict_career_decision_id, :revision], name: "idx_career_decisions_histories"
  end
end
