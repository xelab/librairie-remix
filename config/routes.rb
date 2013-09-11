LibrairieRemix::Application.routes.draw do

  get "books/index"
  get "books/update"
  get "books/create"
  get "books/destroy"
  get "books/new"
  root :to => "books#index", as: :root
  
end
