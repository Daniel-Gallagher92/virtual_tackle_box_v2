class Catch < ApplicationRecord
  belongs_to :user

  validates :species, presence: true
  validates :spot_name, presence: true
  validates :latitude, presence: true
  validates :longitude, presence: true
end
