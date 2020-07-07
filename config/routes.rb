Rails.application.routes.draw do

  post 'authenticate', to: 'authentication#authenticate'


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  concern :commentable do
    resources :comments, only: [:create,:index]
  end
  resources :admins,concerns: :commentable, defaults: {format: :json}, shallow: true do
    resources :bills, only: [:index]
    resources :users,concerns: :commentable do
      resources :bills do
        get 'preview', :on => :member
        resources :comments
      end
    end
  end
end
