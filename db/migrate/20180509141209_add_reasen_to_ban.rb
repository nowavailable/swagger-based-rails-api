class AddReasenToBan < ActiveRecord::Migration[5.2]
  def change
    create_table :admin_users do
    end

    add_column :moral_hazards, :reason, :text

    add_column :answers, :disabled_at, :datetime, default: nil
    add_reference :answers, :moral_hazard
    add_reference :answers, :disabled_by, foreign_key: {to_table: :admin_users}
    add_column :questions, :disabled_at, :datetime, default: nil
    add_reference :questions, :moral_hazard
    add_reference :questions, :disabled_by, foreign_key: {to_table: :admin_users}

    add_column :users, :disabled_at, :datetime, default: nil
    add_column :users, :reason_disabled, :text
    add_reference :users, :disabled_by, foreign_key: {to_table: :admin_users}
  end
end
