class Mentor < ApplicationRecord
  belongs_to :user
  has_many :answers, dependent: :restrict_with_exception
end
