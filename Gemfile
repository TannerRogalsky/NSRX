source 'https://rubygems.org'
source 'http://gems.uken.com'
ruby '2.0.0'

## Core

gem 'rails', '~> 4.0.0'

## Database

gem 'mysql2'
gem 'flag_shih_tzu'
gem 'activerecord-fast-import'
gem 'enum_column3'

## Assets

gem 'sass-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'angularjs-rails'
gem 'angular-rails-templates'
gem 'quiet_assets'
gem 'bourbon'
gem 'sass-mediaqueries-rails'

gem 'rack-offline'

## API

gem 'jbuilder', '~> 1.2'

## Utilities

gem 'faraday'
gem 'redis-rails'
gem 'statsd-ruby'

group :development,:staging, :test do
  # gem 'coffee-rails-source-maps'
  gem 'sass-rails-source-maps'
end

group :development, :test do
  gem 'rspec-rails', '~> 2.0'
  gem 'guard-rspec'
  gem 'terminal-notifier-guard'
  gem 'capistrano'
  gem 'capistrano-ext'
  gem 'pry-rails'
  gem 'byebug' # debugger for ruby2.0
end

group :development do
  # Allow renaming the app to match your repo
  gem 'rename'
  # Useful for deploying on PowerUp ("uken powerup ..." commands)
  gem 'uken'
end

group :staging do
  # Deployment (Powerup)
  gem 'rails_12factor'
end

group :test do
  gem 'webmock'
  gem 'timecop'
end
