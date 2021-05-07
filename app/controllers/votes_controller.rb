class VotesController < ApplicationController
  before_action :authentic_user

  def create
    ManageVotes.call(current_user, params)
    redirect_to request.referer
  end
end
