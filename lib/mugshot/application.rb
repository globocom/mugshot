# -*- encoding: utf-8 -*-
require 'sinatra/base'

class Mugshot::Application < Sinatra::Base

  DEFAULT_VALID_OPERATIONS = %w[background crop resize quality]

  set :static, true
  set :public, ::File.expand_path(::File.join(::File.dirname(__FILE__), "public"))

  before do
    response['Cache-Control'] = "public, max-age=#{@cache_duration}"
  end
  
  get '/?' do
    'ok'
  end

  post '/?' do
    id = @storage.write(params['file'][:tempfile].read)
    halt 405 if id.blank?
    id
  end

  before '/*/?:id/:name.:format' do |splat, id, name, format|
    @operations = operations_from_splat(splat)
    check_operations
    check_format(format)
  end
  
  get '/*/?:id/:name.:format' do |splat, id, _, format|
    image = @storage.read(id)
    halt 404 if image.blank?

    begin
      process_operations(image, @default_operations)
      process_operations(image, @operations)
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
    @cache_duration = opts.delete(:cache_duration) || 1.year.to_i
    @valid_operations = (opts.delete(:valid_operations) || DEFAULT_VALID_OPERATIONS).map(&:to_s)
    @quality_range = opts.delete(:quality_range)
    @allowed_sizes = opts.delete(:allowed_sizes)
    @allowed_formats = opts.delete(:allowed_formats)

    @default_operations = opts
    
    super(opts)
  end

  private

  def operations_from_splat(splat)
    operations = []
    begin
      operations = Hash[*splat.split('/')]
      operations.assert_valid_keys(@valid_operations)
    rescue
      halt 400
    end
    operations
  end
  
  def check_format(format)
    halt 400 unless valid_format?(format)
  end
  
  def valid_format?(format)
    @allowed_formats.blank? || @allowed_formats.map(&:to_s).include?(format)
  end
  
  def check_operations
    halt 400 unless valid_quality_operation? && valid_resize_operation? && valid_crop_operation?
  end
  
  def valid_quality_operation?
    !@operations.has_key?("quality") || @quality_range.blank? || @quality_range.include?(@operations["quality"].to_i)
  end
  
  def valid_resize_operation?
    valid_operation?("resize", @allowed_sizes)
  end
  
  def valid_crop_operation?
    valid_operation?("crop", @allowed_sizes)
  end
  
  def valid_operation?(operation, range_or_array)
    !@operations.has_key?(operation) || range_or_array.blank? || range_or_array.include?(@operations[operation])
  end

  def process_operations(image, operations)
    operations.each do |op, op_params|
      image.send("#{op}!", op_params.to_s)
    end
  end
  
  def send_image(image, format)
    content_type format
    response['Content-Disposition'] = 'inline'
    image.to_blob(:format => format)
  end
end
