require 'net/http'
require 'uri'
require 'tempfile'
require 'json'
require 'dotenv'

Dotenv.load

module ApodHelper
  class ApodInfo
    def run
      uri = URI.parse('https://api.nasa.gov/planetary/apod')
      uri.query = URI.encode_www_form(api_key: ENV['NASA_API_KEY'])

      response = Net::HTTP.get_response(uri)
      response.body if response.is_a?(Net::HTTPSuccess)
    end
  end

  class ApodImage
    def run
      uri = URI.parse('https://api.nasa.gov/planetary/apod')
      uri.query = URI.encode_www_form(api_key: ENV['NASA_API_KEY'])

      response = Net::HTTP.get_response(uri)
      image_url = JSON.parse(response.body)['url'] if response.is_a?(Net::HTTPSuccess)

      download_image(image_url) if image_url
    end

    def download_image(url)
      uri = URI.parse(url)
      tempfile = Tempfile.new
      Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https') do |http|
        response = http.get(uri.request_uri)
        tempfile.write(response.body)
      end
      tempfile.close
      tempfile.path
    end
  end
end
