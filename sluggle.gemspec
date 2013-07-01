# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sluggle/version'

Gem::Specification.new do |spec|
  spec.name          = "sluggle"
  spec.version       = Sluggle::VERSION
  spec.authors       = ["Matt Polito"]
  spec.email         = ["matt.polito@gmail.com"]
  spec.description   = %q{Easy slug functionality}
  spec.summary       = %q{Easy slug functionality}
  spec.homepage      = "https://github.com/mattpolito/sluggle"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 2.13"
  spec.add_development_dependency 'activerecord', '~> 4.0.0'
  spec.add_development_dependency "pry"
  spec.add_development_dependency "database_cleaner"
  spec.add_development_dependency "sqlite3"
end
