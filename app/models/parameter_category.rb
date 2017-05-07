class ParameterCategory < ApplicationRecord
  validates :name, presence: true
  
  has_many :parameters
end
