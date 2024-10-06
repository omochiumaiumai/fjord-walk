Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'welcome#index'
  get "auth/:provider/callback", to: "sessions#callback"
  get '/dashboard/:user_id', to: 'dashboard#show', as: 'dashboard'
  get 'auth/failure', to: redirect('/')

  resources :users, only: [:show, :edit, :update ]
  resources :events, only: [:index, :show, :new, :create, :edit, :update]
end
