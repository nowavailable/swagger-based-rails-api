class CreateRikejobs < ActiveRecord::Migration[5.2]
  def change
    create_table :rikejobs do |t|
      t.string :name, null: false
      t.string :copy
      t.text :comment
      t.text :job_type
      t.text :study_type
      t.boolean :is_active, null: false, default: true
      t.timestamps
    end
  end
end
