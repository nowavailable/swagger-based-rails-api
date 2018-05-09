class DropAndCreateAspirationRikejob < ActiveRecord::Migration[5.2]
  def up
    drop_table :rikejobs_aspiration_histories
    create_table :users_rikejobs do |t|
      t.references :user, null: false, foreign_key: true, index: true
      t.references :rikejob, null: false, foreign_key: true, index: true
      t.timestamp :created_at, null: false
      t.timestamp :revoked_at
      # t.references :grade_history, null: false, foreign_key: true, index: true
      t.references :grade_history, null: true, index: true
      t.integer :revision, null: false
    end
    add_index :users_rikejobs, [:user_id, :rikejob_id, :revision], name: "idx_users_rikejobs"

  end
  def down
    drop_table :users_rikejobs
    create_table :rikejobs_aspiration_histories do |t|
      t.references :user, null: false, foreign_key: true, index: true
      t.references :rikejob, null: false, foreign_key: true, index: true
      t.timestamp :created_at , null: false
      t.timestamp :revoked_at
      t.references :grade_history, null: false, foreign_key: true, index: true
    end
  end
end
