class PlacesController < ApplicationController
    def index
        api_key = "AIzaSyClAPqmEMkzet9hUwkXdh8Qcg8FZg6e2qI"   
        # lat = params[:lat]
        # lng = params[:lng]
        # if coming from localhost, doesnt know IP
        lat = 42.2780
        lng = -83.7382
        if Rails.env.production?
            lat = params[:lat]
            lng = params[:lng]
        end
        query = params[:query]
        @client = GooglePlaces::Client.new(api_key)
        @places = @client.spots(lat, lng, keyword: query, radius: 500)

        if @places.empty?
            # link to new_place_path
            flash[:danger] = "Location not found. Create a new one?"
            return redirect_to root_path
        end

        # if a specific search, send another api request to get alternatives
        if @places.length == 1
            place = @places[0]
            alternatives = @client.spots(place.lat, place.lng, types: place.types, radius: 500)
            @places += alternatives
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
                #weekdays = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
                (0...7).each do |day|
                    OccupancyDay.create(
                        place_id: new_place.id,
                        day: day, #weekdays[day]
                        occupancies: Array.new(24, 3)
                    )
                end
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
        time = Time.new
        @occupancies_now = []
        @places_db.each do |place|
            occupancy_day = OccupancyDay.find_by(place_id: place.id, day: time.wday)
            occupancy = occupancy_day.occupancies[time.hour]
            @occupancies_now.push(occupancy)
        end
    end

    def show
        @place = Place.find(params[:id])
        unless @place
            flash[:danger] = "Location not found"
            return redirect_to root_path
        end
        time = Time.new
        @occupancy_day = OccupancyDay.find_by(place_id: @place.id, day: time.wday)
    end

    # not used
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
        time = Time.now
        @occupancy_day = OccupancyDay.find_by(place_id: @place.id, day: time.wday)
        unless @place
            flash[:danger] = "Location not found"
            return redirect_to root_path
        end
    end

    # degredated, use to update place only. If updating rating, go to update occupancy_day
    def update
        @location = request.location
        @place = Place.find(params[:id])
        unless @place
            flash[:danger] = "Place not found"
            return redirect_to root_path
        end
        #average = (params[:occupancy].to_f + @place.occupancy)/2
        unless @place.update(occupancy: average)
            flash[:danger] = "Could not update place"
            return redirect_to edit_place_path(@place)
        end
        redirect_to place_path(@place)
    end

    # not used
    def destroy
    end
end
