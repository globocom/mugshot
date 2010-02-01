# -*- encoding: utf-8 -*-
require 'rubygems'
require 'rake'

task :default => [:spec, :features]

begin
  require 'jeweler'
  namespace :gem do
    Jeweler::Tasks.new do |gem|
      gem.name = "mugshot"
      gem.summary = %Q{Dead simple image server}
      gem.description = %Q{Dead simple image server}
      gem.email = %w{cainanunes@gmail.com fabriciolopesvital@gmail.com gcirne@gmail.com jose@peleteiro.net}
      gem.homepage = "http://mugshot.ws"
      gem.authors = ["Cainã Nunes", "Fabrício Lopes", "Guilherme Cirne", "Jose Peleteiro"]
      gem.files = FileList["lib/**/*"] + %w{gems.yml gems_dev.yml}
      gem.test_files = FileList["spec/**/*"] + FileList["features/**/*"]

      gem.add_dependency "activesupport"
      gem.add_dependency "sinatra", ">= 0.9.4"
      gem.add_dependency "rmagick", ">= 2.12.2"
      gem.add_dependency "uuid", ">= 2.0.2"

      gem.add_development_dependency "rspec", ">= 1.3.0"
      gem.add_development_dependency "cucumber", ">= 0.6.2"
      gem.add_development_dependency "rack-test", ">= 0.5.1"

      # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
    end
    Jeweler::GemcutterTasks.new
  end
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end

begin
  require 'spec/rake/spectask'
  Spec::Rake::SpecTask.new(:spec) do |spec|
    spec.libs << 'lib' << 'spec'
    spec.pattern = 'spec/**/*_spec.rb'
    spec.rcov = true
    spec.rcov_dir = 'doc/coverage'
    spec.rcov_opts = %w{--text-summary --failure-threshold 100 --exclude spec/*,gems/*,/usr/lib/ruby/*}
  end
  task :spec => 'gem:check_dependencies'
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

