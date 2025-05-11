class SessionsController < ApplicationController
  def new
    redirect_to proponents_path if current_user
  end

  def create
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to proponents_path, notice: 'Login realizado com sucesso!'
    else
      flash.now[:alert] = 'E-mail ou senha inválidos'
      render :new
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to login_path, notice: 'Logout efetuado com sucesso.'
  end
end
