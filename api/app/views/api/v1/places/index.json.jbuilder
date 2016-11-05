json.array!(@places) do |place|
    json.placeid place.place_id
    json.lat place.lat
    json.lng place.lng
    json.name place.name
    #json.occupancy place.occupancy
    json.address place.address_components
    json.type place.types
    #json.description place.description
end