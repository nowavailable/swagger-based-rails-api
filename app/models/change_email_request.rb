class ChangeEmailRequest < ApplicationRecord
  belongs_to :user

  validates :token, presence: true, length: { maximum: 256 }

  def generate_token

  end
end
