json.array!(@places) do |place|
    json.name place.name
    json.occupancy place.occupancy
    json.address place.address
    json.type place.type
    json.description place.description
end