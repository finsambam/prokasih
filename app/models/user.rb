class User < ApplicationRecord
	validates :name, presence: true

	has_and_belongs_to_many :roles
	has_many :articles
	
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  def role?(role)
    return !!self.roles.find_by_name(role.to_s.camelize)
	end
end
