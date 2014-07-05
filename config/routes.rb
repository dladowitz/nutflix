Myflix::Application.routes.draw do

  root to: "pages#home",                       as: :home

  get    "register",      to: "users#new",     as: :register
  get    "signin",        to: "sessions#new",  as: :signin
  # get  "home",          to: "videos#index",  as: :home
  # get  "videos/:id",    to: "videos#show",   as: :video
  # post "vidoes/search", to: "videos#search", as: :search

  get    "ui(/:action)",  controller: "ui"

  resources :users, only: [:create]

  resources :videos, only: [:show, :index] do
    collection do
      get :search, to: "videos#search"
      post :search, to: "videos#search"
    end
  end

end
