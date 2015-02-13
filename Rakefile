require 'rubygems'
require 'fileutils'
require 'bundler'
require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

Bundler.require

task :compile do
  sh 'bundle exec hologram -c hologram/config.yml'

  # Seems like there has to be a better way to do this, but
  # the intent is to give the rendered Hologram HTMLs a .erb extension
  # to pull them into the Middleman rendering flow
  Dir.glob('./source/guide/**/*.html').each do |file|
    File.rename(file, "#{file}.erb")
  end
end

task :server do
  sh 'MIDDLEMAN_SERVER=1 bundle exec middleman server'
end

task :build do
  sh 'bundle exec rake compile'
  sh 'bundle exec middleman build'
end

task :publish do
  sh 'bundle exec rake build'
  sh 'bundle exec middleman s3_sync'
end

namespace :test do
  task all: [:compile, :lib, :middleman, :rails]

  task :lib do
    sh 'bundle exec rspec spec/lib'
  end

  task :middleman do
    sh 'bundle exec rspec spec/features/middleman'
  end

  task :rails do
    sh 'bundle exec rspec spec/features/rails'
  end
end

task test: 'test:all'
task default: [:compile, :server]

%w[INT TERM].each do |signal|
  Signal.trap(signal) do
    puts 'Stopping...'
  end
end
