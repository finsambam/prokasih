class AnalyticParameter < ApplicationRecord
  belongs_to :analytic
  belongs_to :parameter

  scope :by_parameter_id, ->(id) { where(:parameter_id => name) }
end
