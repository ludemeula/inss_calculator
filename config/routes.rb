Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    get 'me', to: 'users#me'
    post 'login', to: 'auth#login'
  end

  root to: 'sessions#new'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get 'up' => 'rails/health#show', :as => :rails_health_check

  resources :proponents do
    collection do
      get :salary_report
      get :calculate_inss
    end
  end
end
