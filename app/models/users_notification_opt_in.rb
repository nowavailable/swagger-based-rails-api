class UsersNotificationOptIn < ApplicationRecord
  belongs_to :user
  belongs_to :dict_notification_opt_in
end
