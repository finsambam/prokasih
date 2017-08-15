class Comment < ApplicationRecord
  belongs_to :parent, :class_name => "Comment", :foreign_key => "parent_id"
  has_many :childs, :class_name => "Comment", :foreign_key => "parent_id"

  validate :must_be_presents
  
  scope :isParent, -> { where(:parent_id => nil) }

  def must_be_presents
  	errors[:base] << "Nama tidak boleh kosong" if name.blank?
    errors[:base] << "Email tidak boleh kosong" if email.blank?
    errors[:base] << "Pesan tidak boleh kosong" if message.blank?
  end

  def check_email_format
  	
  end
end
