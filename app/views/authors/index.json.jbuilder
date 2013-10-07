json.array!(@authors) do |author|
  json.extract! author, 
  json.url author_url(author, format: :json)
end
