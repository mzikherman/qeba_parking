json.array!(@visits) do |visit|
  json.extract! visit, :id, :owner_id, :start_at, :end_at
  json.url visit_url(visit, format: :json)
end
