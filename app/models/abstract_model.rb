class AbstractModel < ActiveRecord::Base
  self.abstract_class = true

  acts_as_api
end
