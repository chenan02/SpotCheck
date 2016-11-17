class Place < ApplicationRecord
    validates_presence_of :place_id, :occupancy
    validates_uniqueness_of :place_id
    has_many :favorites
    has_many :users, through: :favorites
end
