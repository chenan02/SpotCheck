class Occupancy < ApplicationRecord
  validates_presence_of :score, :time, :occupancy_day_id
  belongs_to :occupancy_day
end
