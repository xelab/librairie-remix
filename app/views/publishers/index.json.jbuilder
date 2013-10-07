json.array!(@publishers) do |publisher|
  json.extract! publisher, 
  json.url publisher_url(publisher, format: :json)
end
