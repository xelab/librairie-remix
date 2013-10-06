LibrairieRemix::Application.routes.draw do

  resources :books
  
  root :to => "books#index", as: :root
  
end
