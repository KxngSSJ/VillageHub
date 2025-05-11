class WorkPost < ApplicationRecord
  belongs_to :user                           # Each post belongs to one user (tradesman)
  has_one_attached :image                    # Allows image upload via Active Storage
  has_many :ratings, dependent: :destroy     # Each post can have many ratings. Destroyed if post is deleted.

  # Calculates the average rating for display
  def average_rating
    return 0 if ratings.empty?               # Avoid divide-by-zero
    ratings.average(:score).round(1)         # Compute average and round to 1 decimal
  end
end
