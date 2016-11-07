class FavoritesController < ApplicationController
    def create
        deviceid = params[:deviceid]
        placeid = params[:placeid]
        @favorite = Favorite.new(
            deviceid: deviceid,
            placeid: placeid
        )
        if @favorite.save
            msg = { status: "ok", message: "success :)" }
        else
            msg = { status: "error", message: ":("}
        end
        respond_to do |format|     
            format.json { render json: msg }
        end
        # show failure
    end

    def destroy
        deviceid = params[:deviceid]
        placeid = params[:placeid]
        @favorite = Favorite.find_by(deviceid: deviceid, placeid: placeid)
        if @favorite.destroy
            msg = { status: "ok", message: "success :)" }
        else
            msg = { status: "error", message: ":(" }
        end
        respond_to do |format|
            format.json { render json: msg }
        end
    end
end
