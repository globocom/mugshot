# -*- encoding: utf-8 -*-
require "rubygems"
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..'))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', '..', 'lib'))
require 'mugshot'

require 'rack/test'
require 'rspec/expectations'
require 'pp'

require 'RMagick'

module CucumberWorld
  include Rspec::Matchers
  include Rack::Test::Methods
  
  mattr_accessor :storage

  def app
    Mugshot::Application.new(storage)
  end

  def write_image(filename)
    Mugshot::FSStorage.new('/tmp/mugshot/cucumber').
      write(IO.read(File.expand_path(filename, "features/support/files/")))
  end
end
World(CucumberWorld)

Before do
  @images_by_name = HashWithIndifferentAccess.new
  CucumberWorld.storage = Mugshot::FSStorage.new('/tmp/mugshot/cucumber')
end

After do
  require 'fileutils'
  FileUtils.rm_rf("/tmp/mugshot/cucumber")
end

Rspec::Matchers.define :be_same_image_as do |expected|
  match do |actual|
    expected = Magick::Image.read(File.expand_path(__FILE__ + "/../files/#{expected}")).first if expected.is_a?(String)

    actual.columns == expected.columns &&
    actual.rows == expected.rows &&
    actual.difference(expected)[1] < 0.01
  end
end

