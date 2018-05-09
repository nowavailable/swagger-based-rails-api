class GradeHistory < ApplicationRecord
  belongs_to :user
  belongs_to :dict_grade

  validates :dict_grade_id, presence: true
end
