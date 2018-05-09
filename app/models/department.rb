class Department < ApplicationRecord
  # belongs_to :university
  # belongs_to :vocational_school
  # belongs_to :institute

  validates :name, presence: true
end
