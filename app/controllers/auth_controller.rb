
class AuthController < ApplicationController
    def login
      @user = User.find_by(email: params[:email])

      if @user&.authenticate(params[:password]) # verifica se a senha está correta
        token = encode_token({ user_id: @user.id })
        render json: { token: token }, status: :ok
      else
        render json: { error: 'Credenciais inválidas' }, status: :unauthorized
      end
    end

    private

    # Método para gerar o token JWT
    def encode_token(payload)
      JWT.encode(payload, 'secreta', 'HS256') # 'secreta' é a chave de assinatura
    end
end
