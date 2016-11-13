json.array!(@placesarray) do |place|
    json.placeid place.place_id
    json.lat place.lat
    json.lng place.lng
    json.name place.name
    json.occupancy place.occupancy
    json.address place.vicinity
    json.type place.types
    #json.description place.description
end