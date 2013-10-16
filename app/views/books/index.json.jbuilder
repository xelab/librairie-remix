json.books @books do |book|
  json.(book, :id, :title, :buy, :deposit, :isbn, :price, :release, :title, :summary, :author_ids, :tag_ids, :distributor_id, :publisher_id, :collection_id)
  book_authors = []
  book_authors = book.authors.map { |author| author.fullname }
  json.authors book_authors
  book_tags = book.tags.map { |tag| tag.name }
  json.tags book_tags
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