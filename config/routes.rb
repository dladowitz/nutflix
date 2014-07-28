Myflix::Application.routes.draw do


# verb     /url                   controller#action            #path_name
  get      :queue,                to: "queue_items#index",     as: :queue
  patch    :queue,                to: "queue_items#update"
  get      :signin,               to: "sessions#new",          as: :signin
  get      :people,               to: "relationships#index",   as: :people
  get      :signout,              to: "sessions#destroy",      as: :signout    #used for signout through url
  get      :register,             to: "users#new",             as: :register
  delete   :sessions,             to: "sessions#destroy",      as: :session    #used for signout through link

  root to: "pages#home",                                       as: :home
  get      "ui(/:action)",         controller: "ui"

  resources :users,                only: [:create, :show]
  resources :reviews,              only: [:create]
  resources :sessions,             only: [:create]
  resources :categories,           only: [:show]
  resources :queue_items,          only: [:create, :destroy]
  resources :relationships,        only: [:index, :create, :destroy]

  scope '/admin' do
    get   :password_reset_requests,  to: "admin/password_reset_requests#new",    as: :password_reset_request
    post  :password_reset_requests,  to: "admin/password_reset_requests#create", as: :password_reset_requests

    get   "password_reset/:id",       to: "admin/password_reset#edit",            as: :password_reset
    patch :password_reset,            to: "admin/password_reset#update"
  end

  resources :videos,                 only: [:show, :index] do
    collection do
      get :search,                   to: "videos#search"
      post :search,                  to: "videos#search"
    end
  end

end
