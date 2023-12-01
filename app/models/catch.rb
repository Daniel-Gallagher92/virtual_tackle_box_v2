class Catch < ApplicationRecord
  belongs_to :user
  has_many :catch_lures
  has_many :lures, through: :catch_lures

  validates :species, presence: true
  validates :spot_name, presence: true
  validates :latitude, presence: true
  validates :longitude, presence: true
end
