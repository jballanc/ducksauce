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
  gem.description   = 'DuckSauce handles duck type boilerplate so you don\'t have to.'
  gem.summary       = <<-EOS.lines.map(&:lstrip).join
                        DuckSauce is a gem that takes the hard work out of doing
                        duck typing in Ruby. It allows you to both quickly
                        define generic type coercion helper methods and use
                        those methods to coerce method arguments before the body
                        of your methods.
                      EOS
  gem.homepage      = 'https://github.com/jballanc/ducksauce'

  gem.files         = Dir['{lib,test}/**/*.rb'] + %w|README.md NEWS.md LICENSE.txt ducksauce.gemspec|
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']
end
