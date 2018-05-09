class AddRevition < ActiveRecord::Migration[5.2]
  def change
    add_column :aspiration_high_school_histories, :revision, :integer, null: false, default: 0
    add_index :aspiration_high_school_histories, [:user_id, :revision]
    add_column :aspiration_university_histories, :revision, :integer, null: false, default: 0
    add_index :aspiration_university_histories, [:user_id, :revision]

    add_index :users_rikejobs, [:user_id, :revision]
    add_index :career_decisions_histories, [:user_id, :revision]
  end
end
