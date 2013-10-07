json.array!(@collections) do |collection|
  json.extract! collection, 
  json.url collection_url(collection, format: :json)
end
