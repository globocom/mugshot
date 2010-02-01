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
    expected = Magick::Image.read(File.expand_path(__FILE__ + "/../files/#{expected_filename}")).first
    
    actual.columns == expected.columns && 
    actual.rows == expected.rows && 
    actual.difference(expected)[1] < 0.01
  end
end
