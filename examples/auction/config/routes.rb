Auction::Application.routes.draw do
  root to: 'top#top'

  get 'sign_in' => 'authentication#sign_in'
  get 'sign_up' => 'authentication#sign_up'
  post 'log_in' => 'authentication#log_in'
  get 'sign_out' => 'authentication#sign_out'

  resources :users, only: [:show, :create]

  resources :items
end
