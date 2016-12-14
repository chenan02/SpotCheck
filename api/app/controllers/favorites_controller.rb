class FavoritesController < ApplicationController
    def index
        user_id = params[:user_id]
        @user = User.find(user_id)
        @places = @user.places
        time = Time.now
        @occupancies = []
        @places.each do |place|
            occupancy_day = OccupancyDay.find_by(place_id: place.id, day: time.wday)
            occupancy = occupancy_day.occupancies[time.hour]
            @occupancies.push(occupancy)
        end
    end

    def create
        user_id = params[:user_id]
        place_id = params[:place_id]
        @favorite = Favorite.new(
            user_id: user_id,
            place_id: place_id
        )
        unless @favorite.save
            flash[:danger] = "Already favorited"
            return redirect_to place_path(place_id)
        end
        flash[:success] = "Favorited!"
        return redirect_to place_path(place_id)
    end

    def destroy
        user_id = params[:user_id]
        place_id = params[:place_id]
        @favorite = Favorite.find_by(user_id: user_id, place_id: place_id)
        unless @favorite.destroy
            flash[:danger] = "Unable to unfavorite"
            return redirect_to user_favorites_path
        end
        flash[:success] = "Unfavorited!"
        return redirect_to user_favorites_path
    end
end
