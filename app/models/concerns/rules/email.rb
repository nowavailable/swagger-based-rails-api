module Rules::Email
  @@duplicated = 'このメールアドレスは登録できません。'
  class << self
    def check(requested_email)
      if !duplicate_check(requested_email)
        return @@duplicated
      end
    end

    def duplicate_check(requested_email)
      #
      # 既に登録済みであるメールアドレスは弾く
      #
      duplicateds = User.where(email: requested_email)
      return true if !duplicateds.blank?

      naked_email = remove_gmail_style(requested_email)
      duplicateds_more = User.where(email_without_gmail_style: naked_email)
      return false if !duplicateds_more.blank?

      return true
    end

    def remove_gmail_style(requested_email)
      return requested_email if !requested_email
      #
      # GMailのルールである
      # ・ドット混じりの識別子は、ドットを除外した文字列をもって一意とする
      # ・@の手前の"+XXXXX"は、エイリアスである
      # を踏まえて、これらを利用した同一人物による複数アカウントは除外する。
      #
      splt = requested_email.split("@")
      naked_email = nil
      if m = splt[0].match(/(.+)([\+].*)$/)
        naked_email = m[1].gsub(/[\.]/, "") + "@" + splt[1]
      end
      naked_email ||= requested_email
      return naked_email
    end
  end
end