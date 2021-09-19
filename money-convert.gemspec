require_relative 'lib/money-convert/version'

Gem::Specification.new do |spec|
  spec.name          = "money-convert"
  spec.version       = MoneyConvert::VERSION
  spec.authors       = ["Srinivasa Varma"]
  spec.email         = ["srinivasavarma.d@gmail.com"]

  spec.summary       = %q{Convert one currency to another currency.}
  spec.homepage      = "https://github.com/varmad/MoneyConvert"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.files         =  `git ls-files -z -- config/* lib/* CHANGELOG.md LICENSE money.gemspec README.md`.split("\x0")
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
