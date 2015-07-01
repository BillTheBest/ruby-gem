# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'flowthings/version'

Gem::Specification.new do |s|
  s.name          = "flowthings"
  s.version       = Flowthings::VERSION
  s.authors       = ["Greg Meyer"]
  s.email         = ["dev@flowthings.io"]

  s.summary       = %q{Flowthings.io is an agile intelligence platform that is sifically geared towards the Internet of Things. This is our Ruby Client.}
  s.homepage      = "flowthings.io"

  s.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|s|features)/}) }
  s.bindir        = "exe"
  s.executables   = s.files.grep(%r{^exe/}) { |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.license       = "Apache 2.0"

  if s.respond_to?(:metadata)
    s.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com' to prevent pushes to rubygems.org, or delete to allow pushes to any server."
  end

  s.add_dependency "activesupport", "~> 4.2.0"
  s.add_dependency 'excon', '~> 0.44.4'

  s.add_development_dependency "bundler", "~> 1.8"
  s.add_development_dependency "rake", "~> 10.0"
  s.add_development_dependency "pry", "~> 0.10.1"
  s.add_development_dependency "guard", "~> 2.12.5"
  s.add_development_dependency "guard-rspec", "~> 4.5.0"
end
