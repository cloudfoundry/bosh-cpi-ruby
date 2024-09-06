# coding: utf-8

version_file = File.expand_path('../version', __FILE__)
version = File.exist?(version_file) ? IO.read(version_file) : '0.0.0.dev'

Gem::Specification.new do |spec|
  spec.name        = 'bosh_cpi'
  spec.version     = version
  spec.platform    = Gem::Platform::RUBY
  spec.summary     = 'BOSH CPI'
  spec.description = 'BOSH CPI'
  spec.author      = 'VMware'
  spec.homepage    = 'https://github.com/cloudfoundry/bosh-cpi-ruby/'
  spec.license     = 'Apache 2.0'
  spec.email       = 'support@cloudfoundry.com'
  spec.required_ruby_version = Gem::Requirement.new('>= 1.9.3')

  spec.files        = Dir['lib/**/*'].select{ |f| File.file? f }
  spec.require_path = 'lib'

  spec.add_dependency 'membrane',    '~>1.1.0'
  spec.add_dependency 'httpclient',  '~>2.8.3'
  spec.add_dependency 'rspec'
end
