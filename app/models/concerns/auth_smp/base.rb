# -*- coding: utf-8 -*-
require 'openssl'
require "uri"
require 'open-uri'
require 'rexml/document'

module AuthSmp
  module Base
    @@api_key = Rails.application.credentials.send(Rails.env.to_s)[:shanon_api_key]
    @@key = Rails.application.credentials.send(Rails.env.to_s)[:shanon_key]
    @@password = Rails.application.credentials.send(Rails.env.to_s)[:shanon_password]
    @@host = Settings.send(Rails.env.to_s).shanon_host
    @@callback_url = Settings.send(Rails.env.to_s).site_url + "/after_login"

    def get_application_auth_token
      sig =
        OpenSSL::HMAC.hexdigest('sha1', @@key, "api_key" + @@api_key + "password" + @@password)
      url = @@host + "/services/rest/authentication?" +
        "api_key=" + @@api_key + "&api_sig=" + sig + "&password=" + @@password
      uri = URI.parse(url)
      raw_lines = ""
      obj = open(uri) do|f|
        f.each_line {|line| raw_lines << line}
      end
      if obj.status == ["200", "OK"]
        doc = REXML::Document.new(raw_lines)
        token = doc.elements["Response"].elements["Token"].text
        return token
      else
        raise AuthAgent::AccessFailedError
      end
    end
  end

end