json.array!(@authors) do |author|
  json.(author, :id, :lastname, :firstname, :birthdate, :deathdate)
end
