Rails.application.routes.draw do
  post 'login', to: 'sessions#create'
  delete 'logout' => 'sessions#destroy'
  get '/', to: 'sessions#welcome'
  post 'authenticate', to: 'authentication#authenticate'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  concern :commentable do
    resources :comments, only: [:create,:index]
  end
  resources :admins,concerns: :commentable, defaults: {format: :json}, shallow: true do
    resources :bills, only: [:index]
    resources :users,concerns: :commentable do
      resources :bills do
        resources :comments
      end
    end
  end
end
