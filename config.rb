begin
  require 'pry'
rescue LoadError
  logger.debug 'Pry is missing and will not be loaded.'
end

helpers do
  def guide_path
    '/guide/accordion'
  end
  def repo_url
    'https://github.com/chef/chef-web-core'
  end
end

activate :directory_indexes

activate :s3_sync do |s3_sync|
  s3_sync.bucket = ENV['AWS_S3_BUCKET'] || 'chef-web-core'
  s3_sync.region = ENV['AWS_DEFAULT_REGION'] || 'us-west-1'
end

configure :development do
  activate :livereload

  config[:file_watcher_ignore] << %r{^bower_components(/|$)}
  config[:file_watcher_ignore] << %r{^spec(/|$)}
  config[:file_watcher_ignore] << %r{^\.travis\.yml$}

  timeout = Thread.new(Time.now + 5) do |end_time|

    while Time.now < end_time
      Thread.pass
    end

    logger.info 'Watching for style-guide changes...'
    files.changed /^hologram|^lib|^source\/layouts\/hologram/ do |file|
      `bundle exec rake compile`
    end
  end
end

set :fonts_dir, 'assets/fonts'
set :images_dir, 'assets/images'
set :css_dir, 'assets/stylesheets'
set :js_dir, 'assets/javascripts'

configure :build do
  activate :asset_hash
  activate :minify_css
  activate :minify_javascript
  activate :gzip

  compass_config do |config|
    config.line_comments = false
    config.output_style = :compressed
  end
end
