json.array!(@distributors) do |distributor|
  json.extract! distributor, 
  json.url distributor_url(distributor, format: :json)
end
