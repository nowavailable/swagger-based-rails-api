class Acknowledgement < ApplicationRecord
  belongs_to :answer
  belongs_to :user

  validates :body, presence: true, length: { maximum: 3000 }
end
