class AddColumnAboutEmailCheck < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :email_without_gmail_style, :string, null: false
    add_index :users, [:email_without_gmail_style], unique: true, name: "idx_users_against_gmail_style"
  end
end
