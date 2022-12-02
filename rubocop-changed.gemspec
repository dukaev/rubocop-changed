# frozen_string_literal: true

require_relative 'lib/rubocop/changed/version'

Gem::Specification.new do |spec|
  spec.name          = 'rubocop-changed'
  spec.version       = RuboCop::Changed::VERSION
  spec.required_ruby_version = '>= 2.6.0'
  spec.authors       = ['Aslan Dukaev']
  spec.email         = ['dukaev999@gmail.com']
  spec.summary       = 'RuboCop extensions for lint only changed files in PRs'
  spec.homepage      = 'https://github.com/dukaev/rubocop-changed'
  spec.license       = 'MIT'

  spec.metadata['allowed_push_host'] = 'https://rubygems.org'
  spec.metadata['source_code_uri'] = 'https://github.com/dukaev/rubocop-changed'
  spec.metadata['rubygems_mfa_required'] = 'true'

  spec.files = Dir['lib/**/*.rb']

  spec.add_development_dependency('rspec', '~> 3.12.0')
  spec.add_runtime_dependency('rubocop', '>= 1.0.0')
end
