class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
  include Discard::Model
  default_scope -> { kept }
end
