json.cache!(@place) do
    json.name @place["result"]["name"]
    #json.occupancy place.occupancy
    json.place_id @place["result"]["place_id"]
    json.lat @place["result"]["geometry"]["location"]["lat"]
    json.lng @place["result"]["geometry"]["location"]["lng"]
    json.address @place["result"]["formatted_address"]
    json.type @place["result"]["types"]
    #json.description place.description
end