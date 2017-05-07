class ParameterCategory < ApplicationRecord
  # validates :name, presence: true
  validate :must_be_presents
  
  has_many :parameters

  def must_be_presents
    errors[:base] << "Nama tidak boleh kosong" if name.blank?
  end
end
