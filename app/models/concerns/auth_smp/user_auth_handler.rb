# -*- coding: utf-8 -*-
module AuthSmp
  class UserAuthHandler
    include AuthSmp::Base

    def login
      sig =
        OpenSSL::HMAC.hexdigest('sha1', @@key,
          "api_key" + @@api_key + "callback_url" + @@callback_url)
      url = @@host + "/public/authapi/login?api_key=" +
        @@api_key + "&api_sig=" + sig + "&callback_url=" + @@callback_url
      return url
    end

    def after_login(auth_ttoken)
      user_auth_token = nil
      user = nil
      application_auth_token = get_application_auth_token
      sig =
        OpenSSL::HMAC.hexdigest(
          'sha1', @@key,
          "api_key" + @@api_key + "auth_ttoken" + auth_ttoken +
          "token" + application_auth_token
        )
      url = @@host + "/services/rest/authinfo/token?api_key=" +
        @@api_key + "&api_sig=" + sig + "&auth_ttoken=" + auth_ttoken +
        "&token=" + application_auth_token
      uri = URI.parse(url)
      raw_lines = ""
      obj = open(uri) do |f|
        f.each_line {|line| raw_lines << line}
      end
      if obj.status == ["200", "OK"]
        doc = REXML::Document.new(raw_lines)
        user_auth_token = doc.elements["AuthInfo"].elements["Token"].text
        shanon_user_key = doc.elements["AuthInfo"].elements["UserDataId"].text
        # shanon_user_key = doc.elements["AuthInfo"].elements["UserId"].text

        user_provideds = UserProvided.eager_load(:user).
          where(["smp_provided_user_id = ?  ", shanon_user_key])
        if !user_provideds.blank?
          user = user_provideds.first.user
        else
          raise AuthAgent::AuthFailedError
        end
      else
        raise AuthAgent::AccessFailedError
      end
      return [user, user_auth_token]
    end

    def login_check(user_auth_token)
      is_logged_in = false
      application_auth_token = get_application_auth_token
      sig =
        OpenSSL::HMAC.hexdigest(
          'sha1', @@key,
          "api_key" + @@api_key + "auth_token" + user_auth_token +
            "token" + application_auth_token
        )
      url = @@host + "/services/rest/authinfo/check?api_key=" +
        @@api_key + "&api_sig=" + sig + "&auth_token=" + user_auth_token +
        "&token=" + application_auth_token
      uri = URI.parse(url)
      raw_lines = ""
      obj = open(uri) do |f|
        f.each_line {|line| raw_lines << line}
      end
      if obj.status == ["200", "OK"]
        doc = REXML::Document.new(raw_lines)
        result = doc.elements["AuthInfo"].elements["Result"].text
        is_logged_in = (result == "success")
      else
        raise AuthAgent::AccessFailedError
      end
      return is_logged_in
    end
  end
end

