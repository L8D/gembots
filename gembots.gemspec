# coding: utf-8
lib = File.expand_path('lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "gembots"
  spec.version       = '0.0.03'
  spec.authors       = ["L8D"]
  spec.email         = ["tenorbiel@gmail.com"]
  spec.description   = %q{Library for creating Gembots}
  spec.summary       = %q{Create your own gembots and battle them in a cli arena}
  spec.homepage      = "http://github.com/L8D/gembots"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.files         = ["lib/gembots/arena.rb", "lib/gembots/bot.rb"]
  spec.require_paths = ["lib"]

  spec.add_dependency "gosu"
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
