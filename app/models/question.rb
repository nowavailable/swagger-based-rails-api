class Question < ApplicationRecord
  has_many :answers, dependent: :restrict_with_exception
  belongs_to :user
  belongs_to :question_categories_questions
  has_many :question_categories, through: :question_categories_questions, dependent: :destroy
  has_many :moral_hazards, as: :entry

  validates :question_category_id, presence: true
  validates :user_id, presence: true
  validates :subject, presence: true, length: { maximum: 256 }
  validates :body, presence: true, length: { maximum: 3000 }


end
