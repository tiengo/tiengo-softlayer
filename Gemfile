source 'https://rubygems.org'

gem 'fog-softlayer'

group :development do
  gem 'travis'
  gem 'travis-lint'
  gem 'puppet-blacksmith'
  gem 'guard-rake'
  gem 'pry'
end

group :test do
  gem 'rake'
  gem 'puppet', ENV['PUPPET_GEM_VERSION'] || '~> 4.5.0'
  gem 'puppetlabs_spec_helper'
  gem 'rspec-puppet'
  gem 'webmock'
end
