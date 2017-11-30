class LocationGroup < ActiveRecord::Base
  belongs_to :country
  belongs_to :panel_provider, required: false

  has_many :memberships
  has_many :locations, through: :memberships

  accepts_nested_attributes_for :locations, allow_destroy: true
end
