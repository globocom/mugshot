# -*- encoding: utf-8 -*-
$:.unshift(::File.expand_path(::File.join(::File.dirname(__FILE__), 'lib')))
require 'mugshot'

run Mugshot::Application.new(Mugshot::FSStorage.new('/tmp/mugshot'))
