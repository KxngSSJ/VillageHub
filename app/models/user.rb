class User < ApplicationRecord
  has_secure_password
  has_many :work_posts
  has_many :ratings, dependent: :destroy
end
