class Place < ApplicationRecord
    validates_presence_of :name, :occupancy, :address, :category, :description
    validates_uniqueness_of :placeid
    has_many :devices, through: :favorites
end
