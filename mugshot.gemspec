# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "mugshot/version"

Gem::Specification.new do |s|
  s.name        = "mugshot"
  s.version     = Mugshot::VERSION
  s.authors = ["Cain\303\243 Nunes", "Fabr\303\255cio Lopes", "Guilherme Cirne", "Jose Peleteiro", "Vicente Mundim", "Anselmo Alves"]
  s.email = ["cainanunes@gmail.com", "fabriciolopesvital@gmail.com", "gcirne@gmail.com", "jose@peleteiro.net", "vicente.mundim@gmail.com", "me@anselmoalves.com"]
  s.homepage = %q{http://mugshot.ws}
  s.summary = %q{Dead simple image server}
  s.description = %q{The basic idea of Mugshot is that you upload the largest/highest quality images possible. When retrieving the images you apply different operations to it such as: resizing, rounded corners, transparency and anything else we can think of!}
  s.date = %q{2011-04-25}

  s.rubyforge_project = "mugshot"

  s.rdoc_options = ["--charset=UTF-8"]
  s.extra_rdoc_files = ["LICENSE", "README.md"]

  s.files         = `git ls-files -- lib/*`.split("\n")
  s.test_files    = `git ls-files -- {spec,features}/*`.split("\n")
  s.require_paths = ["lib"]

  s.add_dependency(%q<activesupport>, ["~> 2.3.5"])
  s.add_dependency(%q<i18n>, [">= 0.5.0"])
  s.add_dependency(%q<rmagick>, [">= 2.12.2"])
  s.add_dependency(%q<uuid>, [">= 2.0.2"])
  s.add_dependency(%q<blankslate>, [">= 2.1.2.3"])
  s.add_dependency(%q<sinatra>, [">= 1.2.0"])

  s.add_development_dependency(%q<fakeweb>, [">= 0"])
  s.add_development_dependency(%q<rspec>, [">= 2.3.0"])
  s.add_development_dependency(%q<cucumber>, [">= 0.6.2"])
  s.add_development_dependency(%q<rack-test>, [">= 0.5.1"])
end
