class Api::V1::PlacesController < ApplicationController
    def index
        api_key = "AIzaSyClAPqmEMkzet9hUwkXdh8Qcg8FZg6e2qI"   
        lat = params[:lat]
        lng = params[:lng]
        keyword = params[:keyword]
        @client = GooglePlaces::Client.new(api_key)
        @places = @client.spots(lat, lng, keyword: keyword, radius: 500)
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
            # flash success
            return render json: { status: "ok", message: ":)" }
        end
        render json: { status: "error", message: ":(" }
        # flash warning
        # return
    end

    def update
        @place = Place.where(address: params[:address])
        #fix this
        average = (params[:occupancy] + @place.occupancy)/2
        if @place.update(occupancy: average)
            # redirect
            return render json: { status: "ok", message: ":)" }
        end
        render json: { status: "error", message: ":(" }
            # redirect to edit
        
    end

    def destroy
    end
end
