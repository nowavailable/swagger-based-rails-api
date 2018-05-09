class QuestionCategory < ApplicationRecord
  belongs_to :question_categories_questions
  has_many :questions, through: :question_categories_questions, dependent: :destroy

  validates :label, presence: true, length: { maximum: 256 }
end
