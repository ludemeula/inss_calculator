# app/controllers/api_controller.rb
class ApiController < ActionController::API
  def decode_token(token)
    JWT.decode(token,  Rails.application.secret_key_base, true, algorithm: 'HS256')[0]
  rescue JWT::DecodeError
    nil
  end

  def current_user
    auth_header = request.headers['Authorization']
    token = auth_header.split(' ').last if auth_header.present?

    if token && (decoded_token = decode_token(token))
      @current_user ||= User.find_by(id: decoded_token['user_id'])
    end
  end

  def authenticate_user!
    unless current_user
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end
end
