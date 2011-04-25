# -*- encoding: utf-8 -*-
require "rubygems"
require "rake"
require 'rspec/core/rake_task'
require 'cucumber/rake/task'

task :default => [:spec, :features]

require 'bundler'
Bundler::GemHelper.install_tasks

task :default => [:spec, :cucumber]

RSpec::Core::RakeTask.new :spec
Cucumber::Rake::Task.new(:cucumber)
