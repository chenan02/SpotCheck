class PlacesController < ApplicationController
    def index
        api_key = "AIzaSyClAPqmEMkzet9hUwkXdh8Qcg8FZg6e2qI"   
        # lat = params[:lat]
        # lng = params[:lng]
        # if coming from localhost, doesnt know IP
        if Rails.env.production?
            location = request.location
            lat = location.latitude
            lng = location.longitude
        else
            lat = 42.2780
            lng = -83.7382
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
        counts = []
        @places.each_with_index do |place, index|
            counts.push(index)
            placeid = place.place_id
            place_db = Place.find_by(placeid: placeid)
            unless place_db.nil?
                occupancy = place_db.occupancy
                @occupancies.push(occupancy)
            else
                Place.create(
                    placeid: placeid,
                    occupancy: 5
                )
                @occupancies.push(5)
            end
        end

        @markers = Gmaps4rails.build_markers(counts) do |count, marker|
            marker.lat @places[count].lat
            marker.lng @places[count].lng
            marker.infowindow @occupancies[count].to_s
        end
    end

    def show
        api_key = "AIzaSyClAPqmEMkzet9hUwkXdh8Qcg8FZg6e2qI"
        #placeid = params[:placeid]
        #url = "https://maps.googleapis.com/maps/api/place/details/json?placeid=" + placeid + "&key=" + api_key
        #uri = URI.parse(url)
        #http = Net::HTTP.new(uri.host, uri.port)
        #http.use_ssl = true
        #req = Net::HTTP::Get.new(uri.request_uri)
        #@place = JSON.parse(http.request(req).body)
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
