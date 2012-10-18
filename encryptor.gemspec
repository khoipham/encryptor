# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'encryptor/version'

Gem::Specification.new do |gem|
  gem.name          = "encryptor"
  gem.version       = Encryptor::VERSION
  gem.authors       = ["David Pham"]
  gem.email         = ["hello@khoi.co"]
  gem.summary       = %q{Declaratively encrypt sensitive data}
  gem.description   = %q{Encrypt sensitive data on your ActiveRecord models or plain ol' Ruby objects}
  gem.homepage      = "http://khoi.co"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
