# -*- encoding: utf-8 -*-
require 'mugshot'

require 'rack/test'
require 'rspec/expectations'

require 'pp'

module CucumberWorld
  include Rspec::Matchers
  include Rack::Test::Methods

  def app
    Mugshot::Application.new(Mugshot::FSStorage.new('/tmp/mugshot/cucumber'))
  end
end
World(CucumberWorld)

After do
  require 'fileutils'
  FileUtils.rm_rf("/tmp/mugshot/cucumber")
end

Rspec::Matchers.define :be_same_image_as do |expected_filename|
  match do |actual_blob|
    actual = Magick::Image.from_blob(actual_blob).first
    expected = Magick::Image.read(File.expand_path(__FILE__ + "/../files/#{expected_filename}")).first

    actual.columns == expected.columns &&
    actual.rows == expected.rows &&
    actual.difference(expected)[1] < 0.01
  end
end

Rspec::Matchers.define :have_compression_of do |compression|
  match do |actual_blob|
    actual = Magick::Image.from_blob(actual_blob).first
    actual.quality.to_s == compression.to_s
  end

  failure_message_for_should do |actual_blob|
    actual = Magick::Image.from_blob(actual_blob).first
    "expected #{actual.quality}% but got #{compression}%"
  end
  
  failure_message_for_should_not do |actual|
    "expected #{actual.quality}% not to be #{compression}%"
  end  
end

