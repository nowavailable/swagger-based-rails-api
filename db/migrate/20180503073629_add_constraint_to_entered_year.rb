class AddConstraintToEnteredYear < ActiveRecord::Migration[5.2]
  def up
    change_column :profile_doctors, :entered_year, :integer, null: false
    change_column :profile_high_schools, :entered_year, :integer, null: false
    change_column :profile_junior_highs, :entered_year, :integer, null: false
    change_column :profile_masters, :entered_year, :integer, null: false
    change_column :profile_universities, :entered_year, :integer, null: false
    change_column :profile_vocational_schools, :entered_year, :integer, null: false
  end
  def down
    change_column :profile_doctors, :entered_year, :integer, null: true
    change_column :profile_high_schools, :entered_year, :integer, null: true
    change_column :profile_junior_highs, :entered_year, :integer, null: true
    change_column :profile_masters, :entered_year, :integer, null: true
    change_column :profile_universities, :entered_year, :integer, null: true
    change_column :profile_vocational_schools, :entered_year, :integer, null: true
  end
end
