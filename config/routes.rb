Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'welcome#index'
  get "auth/:provider/callback", to: "sessions#callback"
  get 'auth/failure', to: redirect('/')

end
