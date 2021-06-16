class Image
  attr_reader :credit, :title, :action_description, :location_caption, :url
  def initialize(image_info)
    @credit             = image_info[:credit]
    @title              = image_info[:title]
    @action_description = image_info[:altText]
    @location_caption   = image_info[:caption]
    @url                = image_info[:url]
  end
end
