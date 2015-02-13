ENV['RAILS_ENV'] ||= 'test'

require File.expand_path('../dummy/rails/config/environment.rb', __FILE__)
require 'rspec/rails'
require 'sass/rails'

Rails.backtrace_cleaner.remove_silencers!

RSpec.configure do |config|
  config.use_transactional_fixtures = true
  config.infer_base_class_for_anonymous_controllers = false
end
