class OccupancyDaysController < ApplicationController
    def update
        rating = params[:occupancy]
        occupancy_day = OccupancyDay.find(params[:id])
        place = occupancy_day.place
        #place = params[:place]
        time = Time.now.in_time_zone("Eastern Time (US & Canada)")
        # @place counts on @place being set in a controller action previous
        #occupancy_day = OccupancyDay.find_by(place_id: @place.id, day: time.wday)
        unless occupancy_day
            flash[:danger] = "Place not found"
            return redirect_to root_path
        end
        # put this in model before_save if: :occupancy_day_changed?
        occupancies = occupancy_day.occupancies
        occupancies[time.hour] = (occupancies[time.hour] + rating.to_f)/2
        unless occupancy_day.update(occupancies: occupancies)
            flash[:danger] = "Could not update occupancy"
            return redirect_to edit_place_path(place)
        end
        redirect_to place_path(place)
    end
end
