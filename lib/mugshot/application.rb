require 'sinatra/base'
class Mugshot::Application < Sinatra::Base

  set :static, true
  set :public, ::File.expand_path(::File.join(::File.dirname(__FILE__), "public"))

  before do
    response['Cache-Control'] = "public, max-age=#{1.year.to_i}"
    content_type :jpg    
  end
  
  get '/?' do
    content_type :html
    'ok'
  end

  post '/?' do
    content_type :html
    @storage.write(params['file'][:tempfile].read)
  end

  get '/:size/:id.:format' do |size, id, format|
    image = @storage.read(id)
    halt 404 if image.blank?

    begin
      resize(image, size)
      send_image(image, format.to_sym)
    ensure
      image.destroy!
    end
  end

  protected
  def initialize(storage)
    @storage = storage
  end
  
  def resize(image, size)
    image.resize!(size)
  end

  def send_image(image, format)
    content_type format
    response['Content-Disposition'] = 'inline'
    image.to_blob(:format => format)
  end
end
