# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'slugworth/version'

Gem::Specification.new do |spec|
  spec.name          = "slugworth"
  spec.version       = Slugworth::VERSION
  spec.authors       = ["Matt Polito"]
  spec.email         = ["matt.polito@gmail.com"]
  spec.description   = %q{Easy slug functionality}
  spec.summary       = %q{Easy slug functionality}
  spec.homepage      = "https://github.com/mattpolito/slugworth"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.required_ruby_version = '>= 1.9.2'

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 2.13"
  spec.add_development_dependency 'activerecord', '~> 4.0.0'
  spec.add_development_dependency "pry"
  spec.add_development_dependency "database_cleaner", '~> 1.0.1'
  spec.add_development_dependency "sqlite3"
end
