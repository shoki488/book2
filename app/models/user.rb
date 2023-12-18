class User < ApplicationRecord
  #1対1の関係で紐付ける
  has_one_attached :image
  mount_uploader :avatar, AvatarUploader
  has_many :reservations
  has_many :rooms
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
