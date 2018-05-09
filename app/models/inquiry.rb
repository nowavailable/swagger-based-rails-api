class Inquiry < ApplicationRecord
  CATEGORY = {
    business: 1,
    community: 2
  }
  validates :email_or_user_id, presence: true

  def email_or_user_id
    email.present? or user_id.present?
  end
  private :email_or_user_id

end