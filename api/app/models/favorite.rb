class Favorite < ApplicationRecord
    validates_presence_of :userid, :placeid
    belongs_to :user
    belongs_to :place
end
