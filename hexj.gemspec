# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hexj/version'

Gem::Specification.new do |spec|
  spec.name          = "hexj"
  spec.version       = Hexj::VERSION
  spec.authors       = ["Tamano Ken'iti"]
  spec.email         = ["tamano@ltm.kyoto-u.ac.jp"]
  spec.summary       = %q{Dump a file in hexadecimal and UTF-8 form.}
  spec.description   = %q{Dump a file in hexadecimal and UTF-8 form.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
