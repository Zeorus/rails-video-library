class MoviesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index ]

  def index
    if params[:query].present?
      url = URI("https://imdb8.p.rapidapi.com/auto-complete?q=#{params[:query]}")

      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE

      request = Net::HTTP::Get.new(url)
      request["x-rapidapi-key"] = ENV['RAPIDAPI_KEY']
      request["x-rapidapi-host"] = 'imdb8.p.rapidapi.com'

      response = http.request(request)
      @results = JSON.parse(response.body)["d"]
    end
  end
end
