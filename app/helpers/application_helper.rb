module ApplicationHelper
  def display_upvoted_users(job_id)
    users = Vote.total_upvoted_users(job_id)
    return if users.count.zero?
    if users.count <= 3
      "by #{users.join(', ')}"
    else
      "by #{users.first(3).join(', ')} and #{users.count - 3} more users"
    end
  end
end
