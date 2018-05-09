class CreateMoralHazards < ActiveRecord::Migration[5.2]
  def change
    create_table :moral_hazards do |t|
      t.references :user, null: false, foreign_key: true, index: true
      t.integer :entry_id, null: false
      t.string :entry_type, null: false
      t.text :comment
      t.timestamp :created_at
    end
    add_index :moral_hazards, [:entry_id, :entry_type, :user_id], unique:true, name: "idx_moral_hazards"
  end
end
