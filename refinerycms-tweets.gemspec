# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'refinery/tweets/version'

Gem::Specification.new do |spec|
  spec.name          = "refinerycms-tweets"
  spec.version       = Refinery::Tweets::VERSION
  spec.authors       = ["Chris Holmes"]
  spec.email         = ["tochrisholmes@gmail.com"]
  spec.description   = %q{A Refinery CMS engine to add Twitter functionality.}
  spec.summary       = %q{Tweets allows you add a Twitter feed to your site in seconds.}
  spec.homepage      = "https://github.com/cih/refinerycms-tweets"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'refinerycms-core', '~> 2.1.0'
  spec.add_dependency 'refinerycms-i18n', '~> 2.1.0'
end
