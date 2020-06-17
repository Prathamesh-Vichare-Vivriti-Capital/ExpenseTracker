Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users, defaults: {format: :json} do
    resources :bills, shallow: true
  end
  get 'users/show_all_bills/:id', :to => 'users#show_all_bills'
end
