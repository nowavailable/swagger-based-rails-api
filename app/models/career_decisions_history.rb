class CareerDecisionsHistory < ApplicationRecord
  belongs_to :dict_career_decision
  belongs_to :user
  belongs_to :grade_history, optional: true

  def set_grade_history
    if self.grade_history.blank?
      self.build_grade_history(self.user.latest_grade_history.attributes)
    end
  end

end
