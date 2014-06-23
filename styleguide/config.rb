require 'oc/web/core/helpers'

# In development you can use `binding.pry` anywhere to pause execution and bring
# up a Ruby REPL
begin
  require 'pry'
rescue LoadError
  logger.debug 'Pry is missing and will not be loaded.'
end

# Reload the browser automatically whenever files change
configure :development do
  activate :livereload
end

# Methods defined in the helpers block are available in templates
helpers do
  include OC::Web::Core::Helpers
end

# KSS setup
set :markdown_engine, :redcarpet
activate :kss, kss_dir: '../../lib/assets/stylesheets'

set :css_dir, 'assets/stylesheets'

set :js_dir, 'assets/javascripts'

set :images_dir, 'assets/images'

# Build-specific configuration
configure :build do
  # Enable cache buster
  activate :asset_hash
end
