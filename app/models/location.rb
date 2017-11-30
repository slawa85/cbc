class Location < ActiveRecord::Base
  has_many :memberships
  has_many :location_groups, through: :memberships
end
