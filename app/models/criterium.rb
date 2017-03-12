class Criterium < ApplicationRecord
  has_many :criterium_parameters, dependent: :destroy
  has_many :parameters, through: :criterium_parameters

  accepts_nested_attributes_for :criterium_parameters
  accepts_nested_attributes_for :parameters
end
