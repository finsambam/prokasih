class Documentation < ApplicationRecord

  has_one :article
  mount_uploader :image, ImageUploader
  self.per_page = 10

  validate :must_be_presents
  validate :file_size

  scope :not_article, -> {where(:is_article => false)}

  def file_size
    if image.file.size.to_f/(1000*1000) > 1
      errors.add(:image, "Anda tidak dapat meng-upload foto lebih dari 1MB")
    end
  end

  def must_be_presents
    errors[:base] << "Judul tidak boleh kosong" if title.blank?
    errors[:base] << "Foto tidak boleh kosong" if image.blank?
  end

end