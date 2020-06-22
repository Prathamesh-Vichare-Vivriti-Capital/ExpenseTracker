Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  concern :commentable do
    resources :comments, only: [:create,:index]
  end
  resources :admins,concerns: :commentable, defaults: {format: :json}, shallow: true do
    member do
      get 'bills'
    end
    resources :users,concerns: :commentable do
      resources :bills do
        resources :comments
      end
    end
  end
end
