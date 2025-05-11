class Rating < ApplicationRecord
  # Each rating is linked to one user and one work post
  belongs_to :user
  belongs_to :work_post

  # Score must be present and be between 1 and 5
  validates :score, presence: true, inclusion: { in: 1..5 }

  # Prevents a user from rating the same work post more than once for fair rating
  validates :user_id, uniqueness: { scope: :work_post_id, message: "has already rated this post" }
end
