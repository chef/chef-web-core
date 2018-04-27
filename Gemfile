source 'https://rubygems.org'

gemspec name: 'chef-web-core'

gem 'middleman'
gem 'middleman-core'
gem 'middleman-cloudfront'
gem 'middleman-s3_sync'
gem 'middleman-livereload'
gem 'hologram'
gem 'rake'

gem 'xmlrpc' # middleman uses fog, and fog/xenserver/core.rb requires this,. revisit

group :development, :test do
  gem 'bump'
  gem 'git'
  gem 'pry'
  gem 'rack-cors', :require => 'rack/cors'
end

group :test do
  gem 'rspec-core'
  gem 'rspec'
  gem 'rspec-its'
  gem 'rspec-rails'
  gem 'capybara'
  gem 'sass-rails', '~> 5.0.0'
  gem 'selenium-webdriver'
end
