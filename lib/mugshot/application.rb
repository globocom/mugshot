# -*- encoding: utf-8 -*-
require 'sinatra/base'

class Mugshot::Application < Sinatra::Base

  VALID_OPERATIONS = %w[background crop resize quality]

  set :static, true
  set :public, ::File.expand_path(::File.join(::File.dirname(__FILE__), "public"))

  before do
    response['Cache-Control'] = "public, max-age=#{1.year.to_i}"
  end

  get '/?' do
    'ok'
  end

  post '/?' do
    id = @storage.write(params['file'][:tempfile].read)
    halt 405 if id.blank?
    id
  end

  get '/*/?:id/:name.:format' do |splat, id, _, format|
    image = @storage.read(id)
    halt 404 if image.blank?

    begin
      process_operations(image, @default_operations)
      process_operations(image, operations_from_splat(splat))
      send_image(image, format.to_sym)
    ensure
      image.destroy!
    end
  end

  protected

  def initialize(opts)
    opts = {:storage => opts} if opts.kind_of?(Mugshot::Storage)
    opts.to_options!
    
    @storage = opts.delete(:storage)

    @default_operations = opts
  end

  private

  def operations_from_splat(splat)
    operations = []
    begin
      operations = Hash[*splat.split('/')]
      operations.assert_valid_keys(VALID_OPERATIONS)
    rescue
      halt 404
    end
    operations
  end

  def process_operations(image, operations)
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
