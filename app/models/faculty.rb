class Faculty < ApplicationRecord
  # belongs_to :university
  # # belongs_to :vocational_school

  validates :name, presence: true
end
