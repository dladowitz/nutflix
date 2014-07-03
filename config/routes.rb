Myflix::Application.routes.draw do
  # get 'videos/index'
  get  "home",          to: "videos#index",  as: :home
  get  "videos/:id",    to: "videos#show",   as: :video
  post "vidoes/search", to: "videos#search", as: :search


  get 'ui(/:action)', controller: 'ui'
end
