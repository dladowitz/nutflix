Myflix::Application.routes.draw do
  # get 'videos/index'
  get  "home",          to: "videos#index",  as: :home
  # get  "videos/:id",    to: "videos#show",   as: :video
  # post "vidoes/search", to: "videos#search", as: :search

  resources :videos, only: [:show] do
    collection do
      get :search, to: "videos#search"
      post :search, to: "videos#search"
    end
  end

  get 'ui(/:action)', controller: 'ui'
end
