class Location < AbstractModel
  has_many :memberships
  has_many :location_groups, through: :memberships

  api_accessible :v1_default do |t|
    t.add :id
    t.add :name
    t.add :secret_code
  end
end
