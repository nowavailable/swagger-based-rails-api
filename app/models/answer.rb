class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :mentor
  belongs_to :user
  has_many :acknowledgement, dependent: :restrict_with_exception
  has_many :moral_hazards, as: :entry

  validates :question_id, presence: true
  validates :user_id, presence: true
  validates :seq_num, presence: true, numericality: true
  validates :body, presence: true, length: { maximum: 3000 }
  validates :anchor, presence: true, length: { maximum: 256 }

end
