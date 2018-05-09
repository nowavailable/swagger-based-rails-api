class AddAvatarToUser < ActiveRecord::Migration[5.2]
  def change
    create_table :avatars do |t|
      t.string :label
      t.string :file, null: false
    end
    add_reference :users, :avatar


  end
end
