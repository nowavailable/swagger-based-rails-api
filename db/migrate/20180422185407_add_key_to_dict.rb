class AddKeyToDict < ActiveRecord::Migration[5.2]
  def change
    add_column :dict_grades, :key, :string, null: false
    add_index :dict_grades, [:key], unique: true

    add_column :dict_career_decisions, :key, :string, null: false
    add_index :dict_career_decisions, [:key], unique: true

    add_column :dict_direct_mail_opt_ins, :key, :string, null: false
    add_index :dict_direct_mail_opt_ins, [:key], unique: true

    add_column :dict_notification_opt_ins, :key, :string, null: false
    add_index :dict_notification_opt_ins, [:key], unique: true

    add_column :rikejobs, :key, :string, null: false
    add_index :rikejobs, [:key], unique: true
  end
end
