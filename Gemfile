# -*- encoding: utf-8 -*-
source :gemcutter

gem "activesupport", "~> 2.3.5", :require => "active_support"
gem "sinatra", ">= 0.9.4", :require => "sinatra/base"
gem "rmagick", ">= 2.12.2", :require => "RMagick"
gem "uuid", ">= 2.0.2"

group :test do
  gem "rspec", ">= 2.0.0.a8"
  gem "cucumber", ">= 0.6.2"
  gem "rack-test", ">= 0.5.1"
  gem "fakeweb", ">= 1.2.8"
end

group :tools do
  gem "bundler", :require => nil
  gem "watchr", :require => nil
  gem "rev", :require => nil
  gem 'libnotify' if RUBY_PLATFORM =~ /linux/ # Linux

  gem "jeweler", :require => nil
  gem "rcov", :require => nil
  gem "rerun", :require => nil
  gem "yard", :require => nil

  gem "rake", :require => nil
  gem "thin", :require => nil
  gem "wirble", :require => nil
  gem "hirb", :require => nil
  gem "looksee", :require => nil
  gem "sketches", :require => nil
end

