json.books @books do |book|
  json.(book, :id, :title, :buy, :deposit, :isbn, :price, :release, :title, :summary, :author_ids, :tag_ids, :distributor_id, :publisher_id, :collection_id)
  json.authors book.authors do |author|
    json.(author, :lastname, :firstname)
  end
  json.tags book.tags do |tag|
    json.(tag, :name)
  end
end

json.publishers @publishers do |publisher|
  json.(publisher, :id, :name)
  json.collections publisher.collections do |collection|
    json.(collection, :id, :name, :publisher_id)
  end
end

json.authors @authors

json.distributors @distributors

json.tags @tags