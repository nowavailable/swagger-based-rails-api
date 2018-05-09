class ProfileBusiness < ApplicationRecord
  belongs_to :user, optional: true # 実際には必須だが、バリデ−ションは不要。
  # belongs_to :rikejob

  # validates :company_name, presence: true
end
