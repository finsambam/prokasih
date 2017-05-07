class Comment < ApplicationRecord
  belongs_to :parent, :class_name => "Comment", :foreign_key => "parent_id"
  has_many :childs, :class_name => "Comment", :foreign_key => "parent_id"

  scope :isParent, -> { where(:parent_id => nil) }
end
