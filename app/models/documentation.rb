class Documentation < ApplicationRecord
	validates :title, presence: true
	validates :image, presence: true

	has_one :article
	mount_uploader :image, ImageUploader
	self.per_page = 2
end
