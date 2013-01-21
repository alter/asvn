# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'asvn/version'

Gem::Specification.new do |gem|
  gem.name          = "asvn"
  gem.version       = ASVN::VERSION
  gem.authors       = ["alter"]
  gem.email         = ["alter.pub@gmail.com"]
  gem.description   = %q{TODO: tiny svn wrapper}
  gem.summary       = %q{TODO: gem for quick work with SVN}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency `svn`
end
