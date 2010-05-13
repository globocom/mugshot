# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{mugshot}
  s.version = "0.4.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Cain\303\243 Nunes", "Fabr\303\255cio Lopes", "Guilherme Cirne", "Jose Peleteiro"]
  s.date = %q{2010-05-13}
  s.description = %q{Dead simple image server}
  s.email = ["cainanunes@gmail.com", "fabriciolopesvital@gmail.com", "gcirne@gmail.com", "jose@peleteiro.net"]
  s.extra_rdoc_files = [
    "LICENSE",
     "README.md"
  ]
  s.files = [
    "lib/mugshot.rb",
     "lib/mugshot/application.rb",
     "lib/mugshot/fs_storage.rb",
     "lib/mugshot/http_storage.rb",
     "lib/mugshot/image.rb",
     "lib/mugshot/magick_factory.rb",
     "lib/mugshot/public/crossdomain.xml",
     "lib/mugshot/storage.rb"
  ]
  s.homepage = %q{http://mugshot.ws}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.6}
  s.summary = %q{Dead simple image server}
  s.test_files = [
    "spec/files",
     "spec/files/firefox_png.png",
     "spec/files/test.jpg",
     "spec/files/test_png.png",
     "spec/mugshot",
     "spec/mugshot/application_spec.rb",
     "spec/mugshot/fs_storage_spec.rb",
     "spec/mugshot/http_storage_spec.rb",
     "spec/mugshot/image_spec.rb",
     "spec/mugshot/magick_factory_spec.rb",
     "spec/spec_helper.rb",
     "spec/test.html",
     "features/convert_image_format.feature",
     "features/crop_image.feature",
     "features/define_image_quality.feature",
     "features/resize_image.feature",
     "features/retrieve_image_with_any_name.feature",
     "features/set_background.feature",
     "features/step_definitions",
     "features/step_definitions/all_steps.rb",
     "features/support",
     "features/support/env.rb",
     "features/support/files",
     "features/support/files/test-cropped_to_300x200.jpg",
     "features/support/files/test-resized_to_200x.jpg",
     "features/support/files/test-resized_to_200x200.jpg",
     "features/support/files/test-resized_to_x200.jpg",
     "features/support/files/test-with_75%_of_compression.jpg",
     "features/support/files/test.gif",
     "features/support/files/test.jpg",
     "features/support/files/test.png",
     "features/support/files/with_alpha_channel-with_a_red_background.jpg",
     "features/support/files/with_alpha_channel.png",
     "features/upload_image.feature"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activesupport>, ["~> 2.3.5"])
      s.add_runtime_dependency(%q<sinatra>, [">= 0.9.4"])
      s.add_runtime_dependency(%q<rmagick>, [">= 2.12.2"])
      s.add_runtime_dependency(%q<uuid>, [">= 2.0.2"])
      s.add_runtime_dependency(%q<blankslate>, [">= 2.1.2.3"])
      s.add_development_dependency(%q<fakeweb>, [">= 0"])
      s.add_development_dependency(%q<rspec>, [">= 2.0.0.beta.8"])
      s.add_development_dependency(%q<rcov>, [">= 0.9.8"])
      s.add_development_dependency(%q<cucumber>, [">= 0.6.2"])
      s.add_development_dependency(%q<rack-test>, [">= 0.5.1"])
    else
      s.add_dependency(%q<activesupport>, ["~> 2.3.5"])
      s.add_dependency(%q<sinatra>, [">= 0.9.4"])
      s.add_dependency(%q<rmagick>, [">= 2.12.2"])
      s.add_dependency(%q<uuid>, [">= 2.0.2"])
      s.add_dependency(%q<blankslate>, [">= 2.1.2.3"])
      s.add_dependency(%q<fakeweb>, [">= 0"])
      s.add_dependency(%q<rspec>, [">= 2.0.0.beta.8"])
      s.add_dependency(%q<rcov>, [">= 0.9.8"])
      s.add_dependency(%q<cucumber>, [">= 0.6.2"])
      s.add_dependency(%q<rack-test>, [">= 0.5.1"])
    end
  else
    s.add_dependency(%q<activesupport>, ["~> 2.3.5"])
    s.add_dependency(%q<sinatra>, [">= 0.9.4"])
    s.add_dependency(%q<rmagick>, [">= 2.12.2"])
    s.add_dependency(%q<uuid>, [">= 2.0.2"])
    s.add_dependency(%q<blankslate>, [">= 2.1.2.3"])
    s.add_dependency(%q<fakeweb>, [">= 0"])
    s.add_dependency(%q<rspec>, [">= 2.0.0.beta.8"])
    s.add_dependency(%q<rcov>, [">= 0.9.8"])
    s.add_dependency(%q<cucumber>, [">= 0.6.2"])
    s.add_dependency(%q<rack-test>, [">= 0.5.1"])
  end
end

