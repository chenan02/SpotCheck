class OccupancyDay < ApplicationRecord
  validates_presence_of :place_id, :name
  belongs_to :place
  has_many :occupancies
end
