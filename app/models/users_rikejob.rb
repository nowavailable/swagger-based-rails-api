class UsersRikejob < ApplicationRecord
  belongs_to :rikejob
  belongs_to :user
  belongs_to :grade_history, optional: true

end
