class Notification < ApplicationRecord
  belongs_to :dst_user, class_name: "User", foreign_key: "dst_user_id"
  belongs_to :src_user, class_name: "User", foreign_key: "src_user_id"

  validates :src_event_id, presence: true
  validates :src_event_type, presence: true
  validates :is_read, presence: true
  validates :message_body, presence: true, length: { maximum: 256 }
end
