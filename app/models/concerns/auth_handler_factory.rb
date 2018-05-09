require 'singleton'
class AuthHandlerFactory
  include Singleton

  def self.get_auth_handler
    return AuthSmp::UserAuthHandler.new
  end

  def self.get_user_handler
    return AuthSmp::UserHandler.new
  end
end