require 'lib/oc/web/core/helpers'
require 'lib/oc/web/core/url_helpers'

begin
  require 'pry'
rescue LoadError
  logger.debug 'Pry is missing and will not be loaded.'
end

helpers do
  include OC::Web::Core::Helpers
  include OC::Web::Core::URLHelpers
end

set :css_dir, 'stylesheets'
set :fonts_dir, 'fonts'
set :images_dir, 'images'
set :js_dir, 'javascripts'

activate :directory_indexes

activate :s3_sync do |s3_sync|
  s3_sync.bucket = 'chef-styleguide'
  s3_sync.region = 'us-east-1'
  s3_sync.after_build = false
end

configure :development do
  activate :livereload

  config[:file_watcher_ignore] << %r{^bower_components}
  config[:file_watcher_ignore] << %r{^spec(/|$)}
  config[:file_watcher_ignore] << %r{^\.travis\.yml$}

  timeout = Thread.new(Time.now + 5) do |end_time|

    while Time.now < end_time
      Thread.pass
    end

    logger.info 'Watching for Hologram changes...'
    files.changed /^hologram|^lib|^source\/layouts\/hologram/ do |file|
      `bundle exec rake hologram`
    end
  end
end

configure :build do
end
