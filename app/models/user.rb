class User < ApplicationRecord
  validates :username, presence: true, uniqueness: true

  has_many :votes

  def vote(job_id)
    votes.find_by(job_id: job_id)
  end
end
