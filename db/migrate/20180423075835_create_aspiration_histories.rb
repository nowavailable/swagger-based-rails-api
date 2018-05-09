class CreateAspirationHistories < ActiveRecord::Migration[5.2]
  def change
    create_table :aspiration_high_school_histories do |t|
      t.references :user, null: false, foreign_key: true, index: true
      t.references :grade_history, null: false, foreign_key: true, index: true
      t.references :secondary_school, index: false
      t.references :secondary_school_course, index: false
      t.string :secondary_school_name
      t.string :secondary_school_course_name
      t.text :description, null: true
      t.timestamp :created_at, null: false
    end
    add_index :aspiration_high_school_histories, [:secondary_school_id], name: "idx_aspiration_high_school_histories_1"
    add_index :aspiration_high_school_histories, [:secondary_school_course_id], name: "idx_aspiration_high_school_histories_2"

    create_table :aspiration_university_histories do |t|
      t.references :user, null: false, foreign_key: true, index: true
      t.references :grade_history, null: false, foreign_key: true, index: true
      t.references :university, index: true
      t.references :faculty, index: true
      t.references :department, index: true
      t.string :university_name
      t.string :faculty_name
      t.string :department_name
      t.text :description, null: true
      t.timestamp :created_at, null: false
    end

    add_reference :rikejobs_aspiration_histories, :grade_history, null: false, foreign_key: true, index: true
  end
end
