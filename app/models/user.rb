class User < ApplicationRecord
  has_many :lures, dependent: :destroy
  has_many :catches, dependent: :destroy
  
  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true

  has_secure_password
end
