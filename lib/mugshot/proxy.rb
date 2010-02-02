# -*- encoding: utf-8 -*-
require 'sinatra/base'
require 'net/http'

class Mugshot::Proxy < Sinatra::Base
  get '/*' do
    url = URI.parse "#{@host}/#{params[:splat]}"
    res = Net::HTTP.start(url.host, url.port) {|http|
      http.get(url.path)
    }

    status res.code.to_i

    headers_hash = {}
    res.each_header do |k,v|
      headers_hash[k] = v unless k.to_s =~ /status/i
    end
    headers headers_hash

    res.body
  end

  before do
    halt 405 unless request.get?
  end

  protected

  def initialize(host)
    @host = host
  end
end
