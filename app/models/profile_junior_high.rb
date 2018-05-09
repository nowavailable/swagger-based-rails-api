class ProfileJuniorHigh < ApplicationRecord
  belongs_to :user, optional: true # 実際には必須だが、バリデ−ションは不要。
  belongs_to :secondary_school, optional: true
  belongs_to :secondary_school_course, optional: true

  validates :secondary_school_name, presence: true, length: { maximum: 256 }
  validates :entered_year, presence: true, length: { maximum: 4 }, numericality: true
  before_save :prepare_sync

  def prepare_sync
    self.extend UserAttr::SchoolDataSyncToDict
    self.sync
  end
end
