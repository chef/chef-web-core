ENV['MIDDLEMAN_ENV'] ||= 'test'

require 'middleman'

Capybara.app = Middleman::Application.server.inst do
  set :root, File.expand_path(File.join(File.dirname(__FILE__), '..'))
  set :environment, :test
  set :show_exceptions, false
end