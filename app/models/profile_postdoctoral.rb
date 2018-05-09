class ProfilePostdoctoral < ApplicationRecord
  belongs_to :user, optional: true # 実際には必須だが、バリデ−ションは不要。
  belongs_to :university, optional: true
  belongs_to :institute, optional: true
  belongs_to :faculty, optional: true
  belongs_to :department, optional: true

  before_save :prepare_sync

  def prepare_sync
    self.extend UserAttr::SchoolDataSyncToDict
    self.sync
  end
end
