class Blanket < ActiveRecord::Base
  belongs_to :user
  accepts_nested_attributes_for :user
  has_attached_file :img
  validates :id, presence:true, uniqueness:true
  validates_attachment_content_type :img, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
end
