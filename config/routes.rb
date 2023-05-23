Rails.application.routes.draw do
  Rails.application.routes.draw do
    get '/apod', to: 'apod#get_apod_info'
  end
end
