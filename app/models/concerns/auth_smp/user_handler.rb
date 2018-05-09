# -*- coding: utf-8 -*-
require "rest-client"
module AuthSmp
  class UserHandler
    include AuthSmp::Base

    def get_user_by_email(email)
      application_auth_token = get_application_auth_token
      hash_for_sign = {
        "api_key" => @@api_key,
        "search_key1" => "Email",
        "search_operator1" => "eq",
        "search_value1" => email,
        "token" => application_auth_token
      }
      str_for_sign = ""
      hash_for_sign.sort{|a,b| a[0]<=>b[0]}.each do |k,v|
        str_for_sign << k.to_s + v.to_s
      end
      sig = OpenSSL::HMAC.hexdigest('sha1', @@key, str_for_sign)
      url = @@host + "/services/rest/visitor?api_key=" + @@api_key +
        "&api_sig=" + sig + "&token=" + application_auth_token +
        "&search_key1=Email&search_operator1=eq&search_value1=" + CGI.escape(email)
      uri = URI.parse(url)
      raw_lines = ""
      obj = open(uri) do|f|
        f.each_line {|line| raw_lines << line}
      end
      if obj.status == ["200", "OK"]
        doc = REXML::Document.new(raw_lines)
        id = doc.elements["VisitorDataList"].elements["VisitorData"].elements["Id"].text
        # id = doc.elements["VisitorDataList"].elements["VisitorData"].elements["UserId"].text
        return id
      else
        raise AuthAgent::AccessFailedError
      end
    end

    def post_user(user)
      ignore_itemcheck_value = "1"
      application_auth_token = get_application_auth_token
      hash_for_sign = {
        "api_key" => @@api_key,
        "ignore_itemcheck" => ignore_itemcheck_value,
        "token" => application_auth_token
      }
      user_xml_str, sig =
        before_senddata(user, hash_for_sign)
      url = @@host + "/services/rest/visitor?api_key=" +
        @@api_key + "&api_sig=" + sig + "&token=" + application_auth_token +
        "&ignore_itemcheck=" + ignore_itemcheck_value
      res = RestClient.post(url, user_xml_str, content_type: "application/xml;charset='UTF-8'")
      if [201, 200].include?(res.code)
        smp_provided_user_id = get_user_by_email(user.email).to_i
        return smp_provided_user_id
      else
        raise AuthAgent::AccessFailedError
      end
    end

    def put_user(user)
      ignore_itemcheck_value = "1"
      application_auth_token = get_application_auth_token
      hash_for_sign = {
        "api_key" => @@api_key,
        "ignore_itemcheck" => ignore_itemcheck_value,
        "token" => application_auth_token,
        "update_key" => "", "upsert" => "",
      }
      user_xml_str, sig =
        before_senddata(user, hash_for_sign)
      url = @@host + "/services/rest/visitor?api_key=" +
        @@api_key + "&api_sig=" + sig + "&token=" + application_auth_token +
        "&ignore_itemcheck=" + ignore_itemcheck_value +
        "&upsert=&update_key="
      ActiveRecord::Base.logger.info(PP.pp(user_xml_str, ""))
      res = RestClient.put(url, user_xml_str, content_type: "application/xml;charset='UTF-8'")
      if [201, 200].include?(res.code)
        return true
      else
        raise AuthAgent::AccessFailedError
      end
    end

    def before_senddata(user, hash_for_sign)
      user.extend DataConvert::AppToSmp
      user_xml_str = user.generate_xml

      str_for_sign = ""
      hash_for_sign.sort{|a,b| a[0]<=>b[0]}.each do |k,v|
        str_for_sign << k.to_s + v.to_s
      end
      sig = OpenSSL::HMAC.hexdigest('sha1', @@key, str_for_sign)
      return [user_xml_str, sig]
    end
    private :before_senddata
  end
end