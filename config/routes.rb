LibrairieRemix::Application.routes.draw do

  resources :sale_lines

  resources :books
  resources :authors
  resources :tags
  resources :distributors
  resources :publishers
  resources :collections
  resources :sales

  root :to => "books#index", as: :root
  
end
