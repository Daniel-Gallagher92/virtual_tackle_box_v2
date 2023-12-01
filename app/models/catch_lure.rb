class CatchLure < ApplicationRecord
  belongs_to :catch
  belongs_to :lure

  validates :catch_id, presence: true
  validates :lure_id, presence: true
end