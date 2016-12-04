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
        
        if @places.empty?
            # link to new_place_path
            flash[:danger] = "Location not found. Create a new one?"
            return redirect_to root_path
        end

        #@occupancies = []
        @places_db = []
        @places.each_with_index do |place, index|
            place_id = place.place_id
            place_db = Place.find_by(place_id: place_id)
            unless place_db.nil?
                #occupancy = place_db.occupancy
                #@occupancies.push(occupancy)
                @places_db.push(place_db)
            else
                # error message here? Not needed?
                new_place = Place.create(
                    place_id: place_id,
                    occupancy: 3,
                    name: place.name,
                    address: place.vicinity,
                    lat: place.lat,
                    lng: place.lng,
                    category: place.types
                )
                #@occupancies.push(5)
                @places_db.push(new_place)
            end
        end

        #compose markers
        @marker_objects = []
        #@places.zip(@occupancies).each do |place, occupancy|

            #place_db = Place.find_by(place_id: place.place_id)
        @places_db.each do |place|
            marker = {
                lat: place.lat,
                lng: place.lng,
                infowindow: "<p>" + place.name + "</p>" +
                    "<p>Occupancy: " + place.occupancy.to_s + "</p>" +
                    '<a href="/places/' + place.id.to_s + '">Details</a>'
            }
            @marker_objects.push(marker)
        end

        @markers = Gmaps4rails.build_markers(@marker_objects) do |marker_object, marker|
            marker.lat marker_object[:lat]
            marker.lng marker_object[:lng]
            marker.infowindow marker_object[:infowindow]
        end

        #@closest = Place.find_by(place_id: @places[0].place_id)

    end

    def show
        @place = Place.find(params[:id])
        unless @place
            flash[:danger] = "Location not found"
            return redirect_to root_path
        end
    end

    def create
        @place = Place.new(
            name: params[:name],
            occupancy: params[:occupancy],
            address: params[:address],
            lat: params[:lat],
            lng: params[:lng],
            type: params[:type],
            description: params[:description]
        )
        unless @place.save
            flash[:danger] = "Place already exists"
            # should be new_place_path
            return redirect_to root_path
        end
        redirect_to place_path(@place)
    end

    def edit
        @place = Place.find(params[:id])
        unless @place
            flash[:danger] = "Location not found"
            return redirect_to root_path
        end
    end

    def update
        @location = request.location
        @place = Place.find(params[:id])
        unless @place
            flash[:danger] = "Place not found"
            return redirect_to root_path
        end
        average = (params[:occupancy].to_f + @place.occupancy)/2
        unless @place.update(occupancy: average)
            flash[:danger] = "Could not update place"
            return redirect_to edit_place_path(@place)
        end
        redirect_to place_path(@place)
    end

    def destroy
    end
end
