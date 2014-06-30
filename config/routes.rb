Myflix::Application.routes.draw do
  # get 'videos/index'
  get "home",  to: "videos#index", as: :home
  get "videos/:id", to: "videos#show",  as: :video


  get 'ui(/:action)', controller: 'ui'
end
