class Parameter < ApplicationRecord
  # validates :name, presence: true
  # validates :parameter_category_id, presence: true
  # validates :unit, presence: true
  validate :must_be_presents

  belongs_to :parameter_category

  has_many :analytic_parameters
  has_many :analytics, through: :analytic_parameters

  has_many :criterium_parameters
  has_many :criteria, through: :criterium_parameters

  ANALYTIC_TYPES = ["normal", "dengan kondisi"].freeze
  CRITERIUM_TYPES = ["normal", "rentang nilai"].freeze
  SPECIAL_CHARACTERS = ["=","<", ">", "<=",">="].freeze

  def self.for_select
    ParameterCategory.all.map do |category|
      [category.name, category.parameters.map { |p| [p.name, p.id] }]
    end
  end

  def must_be_presents
    errors[:base] << "Nama tidak boleh kosong" if name.blank?
    errors[:base] << "Kategori Parameter tidak boleh kosong" if parameter_category_id.blank?
    errors[:base] << "Unit tidak boleh kosong" if unit.blank?
  end
end
