class OccupancyDay < ApplicationRecord
  validates_presence_of :place_id, :day
  belongs_to :place
end
