class Criterium < ApplicationRecord
  # validates :name, presence: true
  validate :must_be_presents
  
  has_many :criterium_parameters, dependent: :destroy
  has_many :parameters, through: :criterium_parameters

  accepts_nested_attributes_for :criterium_parameters
  accepts_nested_attributes_for :parameters

  def must_be_presents
    errors[:base] << "Nama tidak boleh kosong" if name.blank?
  end
end
