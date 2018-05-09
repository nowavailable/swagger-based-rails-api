class Api::UsersController < Api::BaseController
  before_action :set_user, only: [:show]

  # GET /users
  # GET /users.json
  def index
    raise InternalError
  end

  # GET /users/1
  # GET /users/1.json
  def show

  end

  # GET /users/new
  def new
    raise InternalError
  end

  # GET /users/1/edit
  def edit
    raise InternalError
  end

  # POST /users
  # POST /users.json
  def create
    raise InternalError
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    raise InternalError
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    raise InternalError
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.fetch(:user, {})
  end
end