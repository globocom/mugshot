# -*- encoding: utf-8 -*-
require 'sinatra/base'

class Mugshot::Application < Sinatra::Base

  set :static, true
  set :public, ::File.expand_path(::File.join(::File.dirname(__FILE__), "public"))

  before do
    response['Cache-Control'] = "public, max-age=#{1.year.to_i}"
  end

  get '/?' do
    'ok'
  end

  post '/?' do
    @storage.write(params['file'][:tempfile].read)
  end

  get '/:size/*/:id.:format' do |size, splat, id, format|
    process_image(size, id, format, splat)
  end

  get '/:size/:id.:format' do |size, id, format|
    process_image(size, id, format)
  end

  protected

  def initialize(storage)
    @storage = storage
  end

  private

  def process_image(size, id, format, splat = nil)
    image = @storage.read(id)
    halt 404 if image.blank?

    begin
      image.resize!(size)
      process_operations(image, splat) unless splat.nil?
      send_image(image, format.to_sym)
    ensure
      image.destroy!
    end
  end

  def process_operations(image, splat)
    operations = Hash[*splat.split('/')]
    operations.assert_valid_keys('crop') rescue halt 404
    operations.each do |op, op_params|
      image.send("#{op}!", op_params)
    end
  end

  def send_image(image, format)
    content_type format
    response['Content-Disposition'] = 'inline'
    image.to_blob(:format => format)
  end
end
