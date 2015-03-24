json.array!(@arts) do |art|
  json.extract! art, :id, :art_id, :name, :description, :catagory, :size, :price, :url
  json.url art_url(art, format: :json)
end
