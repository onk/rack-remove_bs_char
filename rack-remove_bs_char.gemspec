# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "rack-remove_bs_char"
  spec.version       = "0.1.0"
  spec.authors       = ["Takafumi ONAKA"]
  spec.email         = ["takafumi.onaka@gmail.com"]

  spec.summary       = "rack middleware to remove 0x08(\b)."
  spec.description   = "rack middleware to remove 0x08(\b). 0x08 is easily inserted in japanese FEP of Mac OSX."
  spec.homepage      = "https://github.com/onk/rack-remove_bs_char"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
end
