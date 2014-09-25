require 'rubygems'
require 'fileutils'
require 'bundler'
require 'bundler/gem_tasks'

Bundler.require

task :hologram do
  sh 'bin/hologram -c config.yml'

  # Seems like there has to be a better way to do this, but
  # the intent is to give the rendered Hologram HTMLs a .erb extension
  # to pull them into the Middleman rendering flow
  Dir.glob('./source/guide/**/*.html').each do |file|
    File.rename(file, "#{file}.erb")
  end
end

task :unbower do
  FileUtils.cp_r 'vendor/assets/components/foundation/scss/.', 'lib/assets/stylesheets/foundation'
  FileUtils.cp_r 'vendor/assets/components/foundation/js/.', 'lib/assets/javascripts/foundation'
end

task :server do
  sh 'bin/middleman server'
end

task :build do
  sh 'bin/middleman build'
end

task :sync do
  sh 'bin/middleman s3_sync --force'
end

task default: [:hologram, :server]
