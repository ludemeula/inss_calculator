class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def require_login
    redirect_to login_path unless current_user
  end

  def authenticate_user!
    unless current_user
      respond_to do |format|
        format.html { redirect_to login_path, alert: 'Você precisa estar logado para acessar esta página.' }
        format.json { render json: { error: 'Unauthorized' }, status: :unauthorized }
      end
    end
  end  
end
