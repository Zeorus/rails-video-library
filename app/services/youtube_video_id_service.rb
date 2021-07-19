require 'json'
require 'open-uri'

class YoutubeVideoIdService
  def initialize(movie_title)
    @movie_title = movie_title
  end

  def find_video
    query = @movie_title.parameterize(separator: '+', preserve_case: false)
    base_url = "https://www.googleapis.com/youtube/v3/search/?key=#{ENV['YOUTUBE_API_KEY']}&part=snippet&q=bande+annonce+fr+#{query}"
    youtube_videos = parse_url("#{base_url}")['items']
  end

  private

  def parse_url(url)
    # response = open(url).read
    response = Net::HTTP.get(URI.parse(url))
    JSON.parse(response)
  end
end
