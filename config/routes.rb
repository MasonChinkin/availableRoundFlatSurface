Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: "static_pages#root"

  namespace :api, format: {default: :json} do
    resources :users, only: [:create, :edit, :destroy] #edit and destroy are bonus features
    resource :session, only: [:create, :destroy]
  end
end
