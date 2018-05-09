class AddGenderToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :gender, :integer, null: true, default: 0
  end
end
