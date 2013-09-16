json.books @books do |book|
  json.(book, :id, :isbn, :price, :release, :title, :summary)
end