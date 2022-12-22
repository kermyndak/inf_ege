Rails.application.routes.draw do
  root 'homepage#index'
  get 'task/first_part'
  get 'task/second_part'
  get 'task/exam'
  post 'log/log'
  get 'log/sign_in'
  get 'log/sign_out'
  get 'log/sign_up'
  get 'homepage/edit'
  get 'task/task'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
