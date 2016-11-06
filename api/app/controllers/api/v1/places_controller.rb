class Api::V1::PlacesController < ApplicationController
    def index
        api_key = "AIzaSyClAPqmEMkzet9hUwkXdh8Qcg8FZg6e2qI"   
        lat = params[:lat]
        lng = params[:lng]
        #lat = 42.27441200000001
        #lng = -83.7342578
        #type = ["restaurant"]
        type = params[:type]
        @client = GooglePlaces::Client.new(api_key)
        @places = @client.spots(lat, lng, types: type, radius: 500)
        #@places = Place.all
        #puts spots
    end

    def show
        #@place = Place.find_by(params[:id])
        #@place = Place.where(address: params[:address])
        api_key = "AIzaSyClAPqmEMkzet9hUwkXdh8Qcg8FZg6e2qI"
        placeid = params[:placeid]
        #placeid = "ChIJA3q9y0WuPIgRVA6XbahB8Oc"
        url = "https://maps.googleapis.com/maps/api/place/details/json?placeid=" + placeid + "&key=" + api_key
        uri = URI.parse(url)
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        req = Net::HTTP::Get.new(uri.request_uri)
        @place = JSON.parse(http.request(req).body)
       #puts @place
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
            # flash success
            #return
        end
        # flash warning
        # return
    end

    def update
        @place = Place.where(address: params[:address])
        #fix this
        average = (params[:occupancy] + @place.occupancy)/2
        if @place.update(occupancy: average)
            # redirect
        else
            # redirect to edit
        end
    end

    def destroy
    end
end
