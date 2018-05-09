class ProfileOtherAcademic < ApplicationRecord
  belongs_to :user, optional: true # 実際には必須だが、バリデ−ションは不要。
end
