class Room < ApplicationRecord
mount_uploader :image, ImageUploader
has_one_attached :image
has_many :reservations
belongs_to :user
 def self.search(search)
  return Room.all unless search
  Room.where('facility_name LIKE(?)', "%#{search}%")
 end
 validates :facility_name, presence: true
 validates :price, presence: true,  numericality: { greater_than_or_equal_to: 1 }
 validates :address, presence: true
 validates :introduction, presence: true, length: { minimum: 5 }
 validates :image, presence: true
 
end