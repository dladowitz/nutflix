Myflix::Application.routes.draw do

  root to: "pages#home",                           as: :home

  get    "queue",         to: "queue_items#index", as: :queue
  patch  "queue",         to: "queue_items#update"
  get    "register",      to: "users#new",         as: :register
  get    "signin",        to: "sessions#new",      as: :signin
  get    "signout",       to: "sessions#destroy",  as: :signout    #used for signout through url
  delete "sessions",      to: "sessions#destroy",  as: :session    #used for signout through link

  get    "ui(/:action)",  controller: "ui"

  resources :queue_items, only: [:create, :destroy]
  resources :users,       only: [:create, :show]
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
