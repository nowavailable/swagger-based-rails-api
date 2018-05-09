class QuestionCategoriesQuestion < ApplicationRecord
  belongs_to :question
  belongs_to :question_category
end
