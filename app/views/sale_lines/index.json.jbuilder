json.array!(@sale_lines) do |sale_line|
  json.extract! sale_line, :sale_id, :book_id, :buy_quantity, :deposit_quantity, :price
  json.url sale_line_url(sale_line, format: :json)
end
