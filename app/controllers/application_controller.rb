class ApplicationController < ActionController::Base
  include SessionHelper

  private

  def authentic_user
    unless logged_in?
      store_location
      redirect_to login_url
    end
  end
end
