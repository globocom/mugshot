# -*- encoding: utf-8 -*-
require "rubygems"
require "rake"

task :default => [:spec, :features]

begin
  require 'jeweler'
  namespace :gem do
    @jeweler_tasks = Jeweler::Tasks.new do |gem|
      gem.name = "mugshot"
      gem.summary = %Q{Dead simple image server}
      gem.description = %Q{Dead simple image server}
      gem.email = %w{cainanunes@gmail.com fabriciolopesvital@gmail.com gcirne@gmail.com jose@peleteiro.net}
      gem.homepage = "http://mugshot.ws"
      gem.authors = ["Cainã Nunes", "Fabrício Lopes", "Guilherme Cirne", "Jose Peleteiro"]
      gem.files = FileList["lib/**/*"]
      gem.test_files = FileList["spec/**/*"] + FileList["features/**/*"]

      gem.add_dependency "activesupport", "~> 2.3.5"
      gem.add_dependency "sinatra", ">= 1.0"
      gem.add_dependency "rmagick", ">= 2.12.2"
      gem.add_dependency "uuid", ">= 2.0.2"
      gem.add_dependency "blankslate", ">= 2.1.2.3"

      gem.add_development_dependency "fakeweb"
      gem.add_development_dependency "rspec", ">= 2.0.0.beta.8"
      gem.add_development_dependency "rcov", ">= 0.9.8"
      gem.add_development_dependency "cucumber", ">= 0.6.2"
      gem.add_development_dependency "rack-test", ">= 0.5.1"

      # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
    end

    desc 'Install runtime and development dependencies'
    task :install_dependencies do
      @jeweler_tasks.jeweler.gemspec.dependencies.each do |dependency|
        begin
          Gem.activate dependency.name, dependency.version_requirements.to_s
        rescue LoadError
          system %Q{gem install #{dependency.name} --version "#{dependency.version_requirements}"}
        end
      end
    end

    Jeweler::GemcutterTasks.new
  end
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end

begin
  require 'rspec/core/rake_task'
  desc "Run all examples using rcov"
  Rspec::Core::RakeTask.new :spec do |t|
    t.rcov = true
    t.rcov_opts =  %[--failure-threshold 100 --output doc/coverage -Ilib -Ispec --exclude "spec,gems/*,/Library/Ruby/*,.bundle"]
  end
  task :spec => 'gem:check_dependencies'
  task :default => :spec
rescue LoadError
  task :spec do
    abort "Rspec is not available. In order to run features, you must: sudo gem install rspec"
  end
end

begin
  require 'cucumber/rake/task'
  Cucumber::Rake::Task.new(:features)
  task :features => 'gem:check_dependencies'
rescue LoadError
  task :features do
    abort "Cucumber is not available. In order to run features, you must: sudo gem install cucumber"
  end
end

desc 'Runs watchr'
task :watchr do
  system "watchr tests.watchr"
end