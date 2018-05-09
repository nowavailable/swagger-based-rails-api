class CreateCurrentGrades < ActiveRecord::Migration[5.2]
  def change

    create_table :dict_grades do |t|
      t.string :label, null: false
      t.boolean :is_active, null: false, default: true
      t.timestamp :created_at , null: false
    end

    create_table :grade_histories do |t|
      t.references :dict_grade, null: false, foreign_key: true, index: true
      t.references :user, null: false, foreign_key: true, index: true
      t.timestamp :created_at , null: false
    end

    create_table :rikejobs_aspiration_histories do |t|
      t.references :user, null: false, foreign_key: true, index: true
      t.references :rikejob, null: false, foreign_key: true, index: true
      t.timestamp :created_at , null: false
      t.timestamp :revoked_at
    end

    create_table :dict_career_decisions do |t|
      t.string :label, null: false
      t.text :description
      t.boolean :is_active, null: false, default: true
      t.timestamp :created_at, null: false
    end

    create_table :career_decisions_histories do |t|
      t.references :user, null: false, foreign_key: true, index: true
      t.references :dict_career_decision, null: false, foreign_key: true, index: true
      t.timestamp :created_at , null: false
    end
  end
end
