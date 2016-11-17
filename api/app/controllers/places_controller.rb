class PlacesController < ApplicationController
    def index
        api_key = "AIzaSyClAPqmEMkzet9hUwkXdh8Qcg8FZg6e2qI"   
        # lat = params[:lat]
        # lng = params[:lng]
        # if coming from localhost, doesnt know IP
        lat = 42.2780
        lng = -83.7382
        if Rails.env.production?
            @location = request.location
            lat = @location.latitude
            lng = @location.longitude
        end
        query = params[:query]
        @client = GooglePlaces::Client.new(api_key)
        @places = @client.spots(lat, lng, keyword: query, radius: 500)

        # build hashes just to include occupancy and turn to json
        # @placesarray = []
        # @places.each do |place|
        #     placesdict = {}
        #     placesdict["placeid"] = place.place_id
        #     placesdict["lat"] = place.lat
        #     placesdict["lng"] = place.lng
        #     placesdict["name"] = place.name
        #     placesdict["address"] = place.vicinity
        #     placesdict["type"] = place.types
        #     @placesarray.push(placesdict)
        # end

        @occupancies = []
        @places.each_with_index do |place, index|
            placeid = place.place_id
            place_db = Place.find_by(placeid: placeid)
            unless place_db.nil?
                occupancy = place_db.occupancy
                @occupancies.push(occupancy)
            else
                Place.create(
                    placeid: placeid,
                    occupancy: 5,
                    name: place.name,
                    address: place.vicinity,
                    category: place.types
                )
                @occupancies.push(5)
            end
        end

        #compose markers
        @marker_objects = []
        @places.zip(@occupancies).each do |place, occupancy|
            place_db = Place.find_by(placeid: place.place_id)
            marker = {
                lat: place.lat,
                lng: place.lng,
                infowindow: "<p>" + place.name + "</p>" +
                    "<p>Occupancy: " + occupancy.to_s + "</p>" +
                    '<a href="/places/' + place_db.id.to_s + '">Details</a>'
            }
            @marker_objects.push(marker)
        end

        @markers = Gmaps4rails.build_markers(@marker_objects) do |marker_object, marker|
            marker.lat marker_object[:lat]
            marker.lng marker_object[:lng]
            marker.infowindow marker_object[:infowindow]
        end
    end

    def show
        @place = Place.find(params[:id])
    end

    def create
        @place = Place.new(
            name: params[:name],
            occupancy: params[:occupancy],
            address: params[:address],
            type: params[:type],
            description: params[:description]
        )
        if @place.save
            return render json: { status: "ok", message: ":)" }
        end
        render json: { status: "error", message: ":(" }
    end

    def edit
        @place = Place.find(params[:id])
    end

    def update
        @place = Place.where(address: params[:address])
        average = (params[:occupancy] + @place.occupancy)/2
        if @place.update(occupancy: average)
            return render json: { status: "ok", message: ":)" }
        end
        render json: { status: "error", message: ":(" }        
    end

    def destroy
    end
end
