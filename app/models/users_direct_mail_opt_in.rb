class UsersDirectMailOptIn < ApplicationRecord
  belongs_to :user
  belongs_to :dict_direct_mail_opt_in
end
