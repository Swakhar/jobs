class SessionsController < ApplicationController
  def new; end

  def create
    @user = find_user || new_user
    if @user
      log_in @user
      redirect_back_or @user
    else
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end

  private

  def find_user
    User.find_by(username: params[:session][:username])
  end

  def new_user
    user = User.new(username: params[:session][:username])
    user.save
    user
  end
end
