class ManageVotes
  attr_reader :current_user, :params

  def initialize(current_user, params)
    @current_user = current_user
    @params = params
  end

  def self.call(current_user, params)
    new(current_user, params).perform
  end

  def perform
    if current_user.vote(params[:job_id])
      manage_existing_vote
    else
      create_new_vote
    end
  end

  private

  def manage_existing_vote
    if params[:up_vote]
      current_user.vote(params[:job_id]).update(upvote: true, downvote: nil)
    elsif params[:down_vote]
      current_user.vote(params[:job_id]).update(upvote: nil, downvote: true)
    end
  end

  def create_new_vote
    if params[:up_vote]
      current_user.votes.create(job_id: params[:job_id], upvote: true, downvote: nil)
    elsif params[:down_vote]
      current_user.votes.create(job_id: params[:job_id], upvote: nil, downvote: true)
    end
  end
end
