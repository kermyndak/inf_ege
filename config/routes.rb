Rails.application.routes.draw do
  root 'homepage#index'
  post 'log/log'
  get 'log/sign_in'
  get 'log/sign_out'
  get 'log/sign_up'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
