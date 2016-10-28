class Place < ApplicationRecord
    validates_presence_of :name, :occupancy, :address, :type, :description
    validates_uniqueness_of :address
end
