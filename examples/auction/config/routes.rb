Auction::Application.routes.draw do
  root to: 'top#top'

  get 'sign_in' => 'authentication#sign_in'
  get 'sign_up' => 'authentication#sign_up'
  get 'sign_out' => 'authentication#sign_out'
end
