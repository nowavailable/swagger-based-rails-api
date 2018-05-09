module Rules::ForceEmailVerified
  class << self
    def get_joining_request(token)
      joining_requests =
        JoiningRequest.
          eager_load(:user).
          where(token: token).
          where("users.id IS NULL").
          where("token_expired_at > ?", Time.now).
          order("joining_requests.created_at DESC")
      if joining_requests.blank?
        return nil
      end
      return joining_requests.first
    end
  end
end