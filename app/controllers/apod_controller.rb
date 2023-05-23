require './app/helpers/apod_helper.rb'

class ApodController < ApplicationController
  def get_apod_info
    @apod_info = ApodHelper::ApodInfo.new.run
    render json: @apod_info
  end

  def get_apod_image
    @apod_image = ApodHelper::ApodImage.new.run
    send_data @apod_image, type: 'image/jpeg', disposition: 'inline'
  end
end
