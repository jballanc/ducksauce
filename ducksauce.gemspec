# -*- encoding: utf-8 -*-

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ducksauce/version'

Gem::Specification.new do |gem|
  gem.name          = 'ducksauce'
  gem.version       = DuckSauce::VERSION
  gem.authors       = ['Josh Ballanco']
  gem.email         = ['jballanc@gmail.com']
  gem.license       = 'BSD 2-Clause'
  gem.description   = 'DuckSauce gives Ruby duck typing superpowers!'
  gem.summary       = <<-EOS.lines.map(&:lstrip).join
                        DuckSauce provides two pieces that can work together or on their
                        own. The first piece gives you an easy way to create method
                        converters (similar to the built-in `Integer()` method). The
                        second piece lets you use converters to create methods that will
                        dispatch on the type of your arguments.
                      EOS
  gem.homepage      = 'https://github.com/jballanc/ducksauce'

  gem.required_ruby_version = '>= 2.1.0'

  gem.add_development_dependency 'minitest', '~> 5.0'

  gem.files         = Dir['{lib,test}/**/*.rb']
  gem.files        += %w|README.md NEWS.md COPYING ducksauce.gemspec|
  gem.test_files    = gem.files.grep(%r|^test/|)
  gem.require_paths = ['lib']
end
