class JobSearchController < ApplicationController
  before_action :logged_in_user

  def index
    fetch_job_lists(params[:search_place] || 'Munich')
  end

  def create
    if params[:search_place].present?
      redirect_to "#{root_path}?search_place=#{params[:search_place]}"
    else
      redirect_to root_path
    end
  end

  private

  def fetch_job_lists(place)
    url = "https://jobs.github.com/positions.json?location=#{place}"
    response = Faraday.get(url) do |req|
      req.headers['Content-Type'] = 'application/json'
    end
    @jobs = JSON.parse(response.body)
  rescue
    @jobs = []
  end
end
