# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'progne_tapera/version'

Gem::Specification.new do |spec|
  spec.name          = "progne_tapera"
  spec.version       = ProgneTapera::VERSION
  spec.authors       = ["Du Hengfeng"]
  spec.email         = ["topbit.du@gmail.com"]
  spec.summary       = %q{A configurable enumeration for Ruby.}
  spec.description   = %q{Progne Tapera is another enum implementation for Ruby. It focuses on configurable enumeration.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency             "rails",   ">= 4.2"
  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 11.3"
  spec.add_development_dependency "rspec", "~> 3.5"

end
