json.theaters do
  json.array! @theaters do |theater|
    json.id theater.id
    json.name theater.name
  end
end
