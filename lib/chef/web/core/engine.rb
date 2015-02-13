require_relative 'version'

class Chef
  module Web
    module Core
      class Engine < ::Rails::Engine
        require 'foundation-rails'
        require 'sass/rails'

        isolate_namespace Chef::Web::Core

        initializer 'chef-web-core.assets.precompile' do |app|

          # Suppress asset caching in dev and test
          app.config.assets.configure do |env|
            if Rails.env.development? || Rails.env.test?
              env.cache = ActiveSupport::Cache.lookup_store(:memory_store)
            end
          end

          app.config.assets.precompile += %w(
            *.css
            *.js
            *.png
            *.svg
            *.eot
            *.ttf
            *.woff
            *.ai
            *.pptx
          )
        end
      end
    end
  end
end
