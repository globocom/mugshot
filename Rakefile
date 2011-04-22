# -*- encoding: utf-8 -*-
require "rubygems"
require "rake"

task :default => [:spec, :features]

require 'bundler'
Bundler::GemHelper.install_tasks

begin
  require 'rspec/core/rake_task'
  desc "Run all examples using rcov"
  RSpec::Core::RakeTask.new :spec
  task :default => :spec
rescue LoadError
  task :spec do
    abort "Rspec is not available. In order to run features, you must: sudo gem install rspec"
  end
end

begin
  require 'cucumber/rake/task'
  Cucumber::Rake::Task.new(:cucumber)
  task :cucumber
rescue LoadError
  task :cucumber do
    abort "Cucumber is not available. In order to run features, you must: sudo gem install cucumber"
  end
end

desc 'Runs watchr'
task :watchr do
  system "watchr tests.watchr"
end