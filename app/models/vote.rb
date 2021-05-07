class Vote < ApplicationRecord
  belongs_to :user
  validates :job_id, presence: true, uniqueness: { scope: :user_id }
  delegate :username, to: :user

  scope :total_upvotes, -> (job_id) { where(job_id: job_id, upvote: true) }
  scope :total_downvotes, -> (job_id) { where(job_id: job_id, downvote: true) }
  scope :total_upvoted_users, -> (job_id) do
    total_upvotes(job_id).map {|vote| vote.username}
  end
end
