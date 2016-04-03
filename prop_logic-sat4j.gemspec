# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'prop_logic/sat4j/version'

Gem::Specification.new do |spec|
  spec.name          = "prop_logic-sat4j"
  spec.version       = PropLogic::Sat4j::VERSION
  spec.authors       = ["Jkr2255"]
  spec.email         = ["magnesium.oxide.play@gmail.com"]

  spec.summary       = %q{TODO: Write a short summary, because Rubygems requires one.}
  spec.description   = %q{TODO: Write a longer description or delete this line.}
  spec.homepage      = "https://github.com/jkr2255/prop_logic-sat4j"
  spec.license       = "EPL/LGPL"


  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "prop_logic", '>= 0.2.0'
  spec.platform = 'java'

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
