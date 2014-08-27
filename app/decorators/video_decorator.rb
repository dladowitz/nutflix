class VideoDecorator
  attr_reader :video
  extend Forwardable

  def_delegators :video, :average_rating

  def initialize(video)
    @video = video
  end

  def large_poster_image
    if video.large_cover_processing
      "fallback/large_cover_processing.png"
    else
      video.large_cover.url
    end
  end
end
