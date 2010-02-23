# -*- encoding: utf-8 -*-
$:.unshift(::File.expand_path(::File.join(::File.dirname(__FILE__), 'lib')))
require 'mugshot'

system "mkdir -p /tmp/mugshot && cp -f spec/files/test.jpg /tmp/mugshot/test"

run Mugshot::Application.new(
  :storage => Mugshot::ProxyStorage.new{|id| "http://foo.com/#{id}.jpg"}
)
