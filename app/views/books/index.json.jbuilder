json.books @books do |book|
  json.(book, :id, :isbn, :price, :release, :title, :summary)
end

json.publishers @publishers do |publisher|
  json.(publisher, :id, :name)
  json.collections publisher.collections do |collection|
    json.(collection, :id, :name, :publisher_id)
  end
end