Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    resources :events
    resources :users
    resources :user_events, only: [:create, :destroy]
  end

  post 'authenticate', to: 'authentication#authenticate'
end
