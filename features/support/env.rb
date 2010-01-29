require 'mugshot'

require 'rack/test'
require 'spec/expectations'

require 'pp'

module CucumberWorld
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

Spec::Matchers.define :be_same_image_as do |expected_filename|
  match do |actual_blob|
    actual = Magick::Image.from_blob(actual_blob).first
    expected = Magick::Image.read("features/support/files/#{expected_filename}").first
    actual.get_pixels(0, 0, actual.columns, actual.rows) == expected.get_pixels(0, 0, expected.columns, expected.rows)
  end
end
