class Article < ApplicationRecord
	validates :title, presence: true
	validates :content, presence: true
	
	belongs_to :documentation
	belongs_to :user

	self.per_page = 2
end
