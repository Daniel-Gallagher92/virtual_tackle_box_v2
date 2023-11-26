class Lure < ApplicationRecord
  belongs_to :user

  validates :brand, presence: true
  validates :variety, presence: true
  validates :color, presence: true
  validates :weight, presence: true
end
