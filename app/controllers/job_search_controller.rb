class JobSearchController < ApplicationController
  before_action :authentic_user

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
    if Redis.current.get(place).present?
      @jobs = JSON.parse(Redis.current.get(place)).first(10)
    else
      url = "https://jobs.github.com/positions.json?location=#{place}"
      response = Faraday.get(url) do |req|
        req.headers['Content-Type'] = 'application/json'
      end
      @jobs = JSON.parse(response.body).first(10)
      Redis.current.set(place, response.body, ex: 300)
    end
  rescue
    @jobs = []
  end
end
