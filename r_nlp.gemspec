# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'r_nlp/version'

Gem::Specification.new do |spec|
  spec.name          = "r_nlp"
  spec.version       = RNlp::VERSION
  spec.authors       = ["Makoto Hiramatsu"]
  spec.email         = ["s1311536@u.tsukuba.ac.jp"]

  spec.summary       = %q{for nlp}
  spec.description   = %q{nlp with ruby}
  spec.homepage      = "https://github.com/himkt/r_nlp"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "natto"
  spec.add_development_dependency "bundler", "~> 1.8"
  spec.add_development_dependency "rake", "~> 10.0"
end
