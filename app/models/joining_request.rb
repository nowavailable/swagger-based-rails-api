class JoiningRequest < ApplicationRecord
  has_one :user

  validates :token, presence: true, length: { maximum: 256 }
  validates :email, presence: true, length: { maximum: 256 },
    'valid_email_2/email': { mx: false, disposable: false, disallow_subaddressing: false}

  before_validation :generate_token

  EXPIRE_HOUR = 24

  def generate_token
    #
    # てきとうにランダム文字列生成
    #
    now = Time.now
    self.token = BCrypt::Password.create(now.to_i.to_s.reverse, cost: 3)
    self.token = self.token.gsub(/\//, "-")
    self.token = self.token.gsub(/\./, "_")
    last = self.token.length - 1
    self.token = self.token[7..last]
    self.token_expired_at = now + EXPIRE_HOUR.hour
  end

  validate do |r|
    if !r.email.blank?
      if msg = Rules::Email.check(r.email)
        r.errors.add(:email, msg)
      end
    end
  end
end
