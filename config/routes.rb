Rails.application.routes.draw do
  use_doorkeeper
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#index'
  namespace :api do
  	namespace :v1 do
      post 'users/sign_in' => 'users#sign_in'
      post 'users/sign_out' => 'users#sign_out'
      post 'users/sign_up' => 'users#sign_up'
  	end
  end
end
