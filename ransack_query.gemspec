# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ransack_query/version'

Gem::Specification.new do |spec|
  spec.name = 'ransack_query'
  spec.version = RansackQuery::VERSION
  spec.authors = ['Frank West']
  spec.email = ['fwest@heiskell.com']
  spec.summary = %q{Provides a way to build advanced ransack queries.}
  spec.description = %q{Provides a way to build ransack queries without building a form and usable to generate testing queries. }
  spec.homepage = ''
  spec.license = 'MIT'

  spec.files = `git ls-files -z`.split("\x0")
  spec.executables = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rspec-nc'
  spec.add_development_dependency 'guard'
  spec.add_development_dependency 'guard-rspec'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'pry-remote'
  spec.add_development_dependency 'pry-nav'
  spec.add_development_dependency 'factory_girl', '~> 4.4.0'
end
