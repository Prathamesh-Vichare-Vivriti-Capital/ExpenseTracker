Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :admins, defaults: {format: :json}, shallow: true do
    member do
      get 'bills'
    end
    resources :users do
      resources :bills
    end
  end
end
