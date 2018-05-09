class Avatar < ApplicationRecord
  has_many :users
  mount_uploader :file, AvatarUploader
end