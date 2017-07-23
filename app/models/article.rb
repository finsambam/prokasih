class Article < ApplicationRecord
	# validates :title, presence: true
	# validates :content, presence: true
	validate :must_be_presents
	
	belongs_to :documentation
	belongs_to :user

	self.per_page = 10

	def must_be_presents
    errors[:base] << "Judul tidak boleh kosong" if title.blank?
    errors[:base] << "Konten tidak boleh kosong" if content.blank?
  end
end
