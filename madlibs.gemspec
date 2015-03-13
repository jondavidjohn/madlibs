# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'madlibs/version'
require 'date'

Gem::Specification.new do |spec|
  spec.name          = "madlibs"
  spec.version       = Madlibs::VERSION
  spec.authors       = ["Jonathan D. Johnson"]
  spec.email         = ["me@jondavidjohn.com"]
  spec.description   = %q{Because sometimes, you just need to make something stupid.}
  spec.summary       = %q{Create generated text with a combination of coditional templating and a provided dictionary}
  spec.homepage      = "https://github.com/jondavidjohn/madlibs"
  spec.license       = "Apache v2"

  spec.files         = `git ls-files`.split($/)
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "activesupport", ">= 3.0.0"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
