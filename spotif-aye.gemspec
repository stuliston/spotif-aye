# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "spotif-aye/version"

Gem::Specification.new do |s|
  s.name        = "spotif-aye"
  s.version     = SpotifAye::VERSION
  s.authors     = ["Stuart Liston"]
  s.email       = ["stuart.liston@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Wrapper for Spotify's Metadata API}
  s.description = %q{Tries to provide a nicer interface to the metadata api provided by Spotify}

   # Running dependencies
  s.add_dependency "httparty", ">= 0.8.1"

  # Development dependencies:
  s.add_development_dependency "rspec", ">= 2.7.0"
  s.add_development_dependency "i18n", ">= 0.6.0"
  s.add_development_dependency "webmock"

  s.rubyforge_project = "spotif-aye"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
end