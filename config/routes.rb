Myflix::Application.routes.draw do

  root to: "pages#home",                           as: :home

  get    "queue",         to: "queue_items#index", as: :queue
  get    "register",      to: "users#new",         as: :register
  get    "signin",        to: "sessions#new",      as: :signin
  get    "signout",       to: "sessions#destroy",  as: :signout    #used for signout through url
  delete "sessions",      to: "sessions#destroy",  as: :session    #used for signout through link

  # get  "home",          to: "videos#index",      as: :home
  # get  "videos/:id",    to: "videos#show",       as: :video
  # post "vidoes/search", to: "videos#search",     as: :search

  get    "ui(/:action)",  controller: "ui"

  resources :users,       only: [:create]
  resources :sessions,    only: [:create]
  resources :categories,  only: [:show]
  resources :reviews,     only: [:create]

  resources :videos,      only: [:show, :index] do
    collection do
      get :search,        to: "videos#search"
      post :search,       to: "videos#search"
    end
  end

end
