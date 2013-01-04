Example::Application.routes.draw do
  resources :book_store, :only => [:show] do
    member do
      post :purchase
    end
  end
end
