class Parameter < ApplicationRecord
	validates :name, presence: true
	validates :parameter_category_id, presence: true
	validates :unit, presence: true

	belongs_to :parameter_category

	has_many :analytic_parameters
	has_many :analytics, through: :analytic_parameters

	has_many :criterium_parameters
	has_many :criteria, through: :criterium_parameters
end
