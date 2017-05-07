class User < ApplicationRecord
  # validates :name, presence: true
  validate :must_be_presents

  has_and_belongs_to_many :roles
  has_many :articles
  
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  def role?(role)
    return !!self.roles.find_by_name(role.to_s.camelize)
  end

  def must_be_presents
    errors[:base] << "Nama tidak boleh kosong" if name.blank?
  end
end
