class AuthAgent
  attr_accessor :auth_handler, :user_handler

  class AuthFailedError < StandardError; end
  class AccessFailedError < StandardError; end

  def initialize
    @auth_handler = AuthHandlerFactory.get_auth_handler
    @user_handler = AuthHandlerFactory.get_user_handler
  end

  def login
    redirect_url = @auth_handler.login
    return redirect_url
  end

  def after_login(auth_ttoken)
    #
    # ログインの確定
    #
    return @auth_handler.after_login(auth_ttoken)
  end

  def login_check(user_auth_token)
    return @auth_handler.login_check(user_auth_token)
  end

  def post_user(user)
    provieded_user_id = @user_handler.post_user(user)
    return provieded_user_id
  end

  def put_user(user)
    @user_handler.put_user(user)
  end
end