Rails.application.routes.draw do
  get "/check_visitor", to: 'visitors#check_visitor', as: 'check_visitor'
  resources :visitors
  devise_for :users
  devise_scope :user do  
    get '/users/sign_out' => 'devise/sessions#destroy'     
  end

  root to:'visitors#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
