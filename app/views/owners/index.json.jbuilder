json.array!(@owners) do |owner|
  json.extract! owner, :id, :pass_id, :name
  json.url owner_url(owner, format: :json)
end
