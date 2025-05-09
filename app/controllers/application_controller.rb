class ApplicationController < ActionController::Base
  # allow_browser versions: :modern
  # Desabilitar a verificação de CSRF para APIs
  protect_from_forgery with: :null_session

  def decode_token(token)
    JWT.decode(token, 'secreta', true, algorithm: 'HS256')[0]
  rescue JWT::DecodeError
    nil
  end

  # Método para obter o usuário a partir do token
  def current_user
    if decoded_token = decode_token(request.headers['Authorization'].split(' ').last)
      @current_user ||= User.find_by(id: decoded_token['user_id'])
    end
  end

  # Verifica se o usuário está autenticado
  def authenticate_user!
    render json: { error: 'Unauthorized' }, status: :unauthorized unless current_user
  end
end
