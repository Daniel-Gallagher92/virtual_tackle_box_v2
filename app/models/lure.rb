class Lure < ApplicationRecord
  belongs_to :user
  has_many :catch_lures
  has_many :catches, through: :catch_lures

  validates :brand, presence: true
  validates :variety, presence: true
  validates :color, presence: true
  validates :weight, presence: true
end
