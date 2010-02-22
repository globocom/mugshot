# -*- encoding: utf-8 -*-
require 'rubygems'
$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'mugshot'

require 'rspec'
require 'rspec/autorun'
require 'rack/test'
require 'pp'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

Rspec.configure do |config|
  require 'rspec/expectations'
  config.include Rspec::Matchers
  config.include Rack::Test::Methods

  config.mock_with :rspec
end
