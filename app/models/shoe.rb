class Shoe < ActiveRecord::Base

  belongs_to :user
  has_many :comments, dependent: :destroy


  validates :name, presence: true
  validates :image, presence: true
  
  mount_uploader :image, ImageUploader
  
end
