class FavoritesController < ApplicationController
    def index
    end
    
    def create
        deviceid = params[:deviceid]
        placeid = params[:placeid]
        @favorite = Favorite.new(
            deviceid: deviceid,
            placeid: placeid
        )
        if @favorite.save
            #msg = { status: "ok", message: "success :)" }
            return render json: { status: "ok", message: ":)" }
        end
            #msg = { status: "error", message: ":("}
        render json: { status: "error", message: ":(" }
        # respond_to do |format|     
        #     format.json { render json: msg }
        # end
    end

    def destroy
        deviceid = params[:deviceid]
        placeid = params[:placeid]
        @favorite = Favorite.find_by(deviceid: deviceid, placeid: placeid)
        if @favorite.destroy
            #msg = { status: "ok", message: "success :)" }
            return render json: { status: "ok", message: ":)" }
        end
            #msg = { status: "error", message: ":(" }
        render json: { status: "error", message: ":(" }
        # respond_to do |format|
        #     format.json { render json: msg }
        # end
    end
end
