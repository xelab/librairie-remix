LibrairieRemix::Application.routes.draw do

  resources :books
  resources :authors
  root :to => "books#index", as: :root
  
end
