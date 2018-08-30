Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root("favourites#index")
  resources :favourites, only: [:index, :new, :create]
  resources :allfavourites, only: :index
end
