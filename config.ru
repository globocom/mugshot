# -*- encoding: utf-8 -*-
$:.unshift(::File.expand_path(::File.join(::File.dirname(__FILE__), "lib")))
require "mugshot"

system "mkdir -p /tmp/mugshot"
%w[test.jpg with_alpha_channel.png].each do |filename|
  system "cp -f features/support/files/#{filename} /tmp/mugshot/#{filename.split('.').first}"
end

run Mugshot::Application.new(
  :storage => Mugshot::FSStorage.new("/tmp/mugshot")
)

