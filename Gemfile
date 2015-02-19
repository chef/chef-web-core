source 'https://rubygems.org'

gemspec name: 'chef-web-core'

# Use Middleman-stable for the conflation of these issues, which cause mayhem in test:
# https://github.com/middleman/middleman-sprockets/issues/56
# https://github.com/Compass/compass/issues/1529
gem 'middleman', :github => 'middleman/middleman', :branch => 'v3-stable'

gem 'middleman-core'
gem 'middleman-s3_sync'
gem 'middleman-livereload'
gem 'sass', '~> 3.4.4'
gem 'hologram'

group :development, :test do
  gem 'pry'
end

group :test do
  gem 'rspec-core'
  gem 'rspec'
  gem 'rspec-its'
  gem 'capybara'
  gem 'sass-rails', '~> 5.0.0'
  gem 'selenium-webdriver'
end