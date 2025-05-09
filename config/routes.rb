Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  # get "calculate_inss", to: "proponents#calculate_inss"

  resources :proponents do
    collection do
      get :salary_report
      get :calculate_inss
    end

    resources :contacts, only: [:destroy]
  end

  root "proponents#index"
end
