Rails.application.routes.draw do
  get 'up' => 'rails/health#show', as: :rails_health_check

  post 'login', to: 'auth#login'

  resources :proponents do
    collection do
      get :salary_report
      get :calculate_inss
    end
  end

  root 'proponents#index'
end
