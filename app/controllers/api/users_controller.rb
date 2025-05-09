class Api::UsersController < ApiController
  before_action :authenticate_user!

  def me
    render json: current_user
  end
end
