class Api::V1::PlacesController < ApplicationController
    def index
        @places = Place.all
    end

    def show
        @place = Place.where(address: params[:address])
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
