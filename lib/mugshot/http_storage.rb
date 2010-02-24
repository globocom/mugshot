# -*- encoding: utf-8 -*-

require 'fileutils'
require 'net/http'

class Mugshot::HTTPStorage < Mugshot::Storage
  def read(id)
    url = URI.parse(@url_resolver.call(id))
    res = Net::HTTP.start(url.host, url.port) {|http| http.get(url.path)}

    return nil unless res.code.to_i == 200

    Mugshot::Image.new(res.body)
  end

  protected

  def initialize(&block)
    @url_resolver = block
  end
end
