require 'chef/web/core/asset_helpers'
require 'chef/web/core/url_helpers'

begin
  require 'pry'
rescue LoadError
  logger.debug 'Pry is missing and will not be loaded.'
end

helpers do
  include Chef::Web::Core::AssetHelpers
  include Chef::Web::Core::URLHelpers

  def guide_path
    '/guide/accordion'
  end

  def current_version
    Chef::Web::Core::VERSION
  end

  def repo_url
    'https://github.com/chef/chef-web-core'
  end

  def download_url
    "#{repo_url}/releases/download/#{current_version}/chef-web-core-#{current_version}.tgz"
  end
end

set :fonts_dir, 'assets/fonts'
set :images_dir, 'assets/images'
set :css_dir, 'assets/stylesheets'
set :js_dir, 'assets/javascripts'

sprockets.import_asset 'vendor/modernizr'

def test?
  ENV['MIDDLEMAN_ENV'] == 'test'
end

def server?
  !ENV['MIDDLEMAN_SERVER'].nil?
end

activate :directory_indexes

unless test?
  activate :s3_sync do |s3_sync|
    s3_sync.bucket = ENV['AWS_S3_BUCKET'] || 'chef-web-core'
    s3_sync.region = ENV['AWS_DEFAULT_REGION'] || 'us-west-1'

    # Don't delete things that are remote but not local, because
    # CI-built resources will be exactly that. We should leave this 
    # setting in place until we have a reliable way to tell s3_sync 
    # to ignore remote resources by pattern. 
    s3_sync.delete = false
  end 

  activate :cloudfront do |cloudfront|
    cloudfront.access_key_id     = ENV['AWS_ACCESS_KEY_ID']
    cloudfront.secret_access_key = ENV['AWS_SECRET_ACCESS_KEY']
    cloudfront.distribution_id   = ENV['CLOUDFRONT_DISTRIBUTION_ID']
  end
end

configure :development do
  activate :livereload if server?

  config[:file_watcher_ignore] << %r{^bower_components(/|$)}
  config[:file_watcher_ignore] << %r{^spec(/|$)}
  config[:file_watcher_ignore] << %r{^\.travis\.yml$}

  delayed = Thread.new(Time.now + 5) do |end_time|

    while Time.now < end_time
      Thread.pass
    end

    files.changed /^hologram|^lib|^source\/layouts\/hologram/ do |file|
      system 'bundle exec rake compile:hologram'
    end

    delayed.kill
  end

  require 'rack/cors'
  use Rack::Cors do
    allow do
      origins '*'
      resource '*.svg',  
        methods: [:get, :options]
    end
  end
end

configure :build do
  activate :minify_css
  activate :minify_javascript
  activate :cache_buster
  activate :gzip
end
