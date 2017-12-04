PANEL_PROVIDER = {
  code: :string,
  price: :float,
}

LOCATION = {
  id: :integer,
  name: :string,
  secret_code: :string
}

COUNTRY = {
  code: :string,
  location_groups: :array_of_objects,
  panel_provider: PANEL_PROVIDER
}

TARGET_GROUP = {
  id: :integer,
  name: :integer_or_null,
  sub_groups: :array_of_objects
}
