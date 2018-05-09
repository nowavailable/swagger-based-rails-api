class ProfileUniversity < ApplicationRecord
  belongs_to :user, optional: true # 実際には必須だが、バリデ−ションは不要。
  belongs_to :university, optional: true
  belongs_to :faculty, optional: true
  belongs_to :department, optional: true

  validates :university_name, presence: true, length: { maximum: 256 }
  validates :entered_year, presence: true, length: { maximum: 4 }, numericality: true
  before_save :prepare_sync

  def prepare_sync
    self.extend UserAttr::SchoolDataSyncToDict
    self.sync
  end

  def concat_name
    name = self.university_name
    if !self.faculty_name.blank?
      name += self.faculty_name
    end
    if !self.department_name.blank?
      name += self.department_name
    end
    return name
  end
end
