# -*- encoding: utf-8 -*-
$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'rubygems'
require 'mugshot'

require 'spec'
require 'spec/autorun'
require 'rack/test'
require 'pp'

Spec::Runner::QuietBacktraceTweaker::IGNORE_PATTERNS << /\/Library\//

Spec::Runner.configure do |config|
  config.include Rack::Test::Methods
end
