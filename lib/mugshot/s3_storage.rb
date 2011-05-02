# -*- encoding: utf-8 -*-
require 'fog'

class Mugshot::S3Storage < Mugshot::Storage

  HEADERS = {'x-amz-acl' => 'public-read'}

  def write(bin)
    id = asset_id
    path = id_to_path(id)
    @storage.put_object(@bucket_name, path, bin, HEADERS)
    id
  end

  def read(id)
    path = id_to_path(id)
    Mugshot::Image.new(@storage.get_object(@bucket_name, path).body)
  rescue Excon::Errors::NotFound
    nil
  end

protected

  def initialize(opts)
    opts.to_options!
    opts.assert_valid_keys(:bucket_name, :access_key_id, :secret_access_key)

    @bucket_name = opts[:bucket_name]

    @storage = Fog::Storage.new(:provider => 'AWS', :aws_access_key_id => opts[:access_key_id], :aws_secret_access_key => opts[:secret_access_key])
    @storage.put_bucket(@bucket_name)
  end

end


