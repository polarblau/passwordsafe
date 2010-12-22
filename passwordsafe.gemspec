# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "passwordsafe/version"

Gem::Specification.new do |s|
  s.name        = "passwordsafe"
  s.version     = Passwordsafe::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["thecatwasnot"]
  s.email       = ["thecatwasnot@gmail.com"]
  s.homepage    = "http://rubygems.org/gems/passwordsafe"
  s.summary     = %q{Small command line app for storing passwords}
  s.description = %q{Small command line app for storing passwords}

  s.rubyforge_project = "passwordsafe"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency('bundler')
  s.add_development_dependency('rspec')
  s.add_development_dependency('cucumber')
  s.add_development_dependency('aruba')

  s.add_dependency "thor"
  s.add_dependency "highline"
end

