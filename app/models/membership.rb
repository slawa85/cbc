class Membership < ActiveRecord::Base
  belongs_to :location
  belongs_to :location_group
end
