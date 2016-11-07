class DevicesController < ApplicationController
    def index
        deviceid = params[:deviceid]
        device = Device.find_by(deviceid: deviceid)
        @fav_places = device.places
    end
end
