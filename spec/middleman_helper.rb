ENV['MIDDLEMAN_ENV'] ||= 'test'

require 'middleman'
require "middleman/rack"
require "middleman-core/rack"
require "rspec"
require "capybara/rspec"

module MiddlemanApplication
  extend RSpec::SharedContext

  main_app = ::Middleman::Application.new do ||
    config[:watcher_disable] = true
  end

  let(:app) do
    main_app
  end

  Capybara.app = ::Middleman::Rack.new(main_app).to_app do
    set :root, File.expand_path(File.join(File.dirname(__FILE__), ".."))
    set :environment, :development
    set :show_exceptions, false
  end
end
