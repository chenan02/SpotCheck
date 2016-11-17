class Favorite < ApplicationRecord
    validates_presence_of :user_id, :place_id
    validates_uniqueness_of :place_id, scope: :user_id
    belongs_to :user
    belongs_to :place
end
