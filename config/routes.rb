LibrairieRemix::Application.routes.draw do

  resources :books
  resources :authors
  resources :tags
  resources :distributors
  resources :publishers
  resources :collections
  get '/livres', to: "books#index"

  root :to => "books#index", as: :root
  
end
