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

task :view do
  sh 'MIDDLEMAN_SERVER=1 bundle exec middleman server'
end

task :build do
  sh 'bundle exec rake compile'
  sh 'bundle exec middleman build'
end

namespace :version do
  version = File.read('VERSION')

  task :set do
    package = JSON.parse(File.read('package.json'))
    package['version'] = version
    File.write('package.json', JSON.pretty_generate(package))
  end

  task :bump, :level do |t, args|
    require 'git'

    level = args[:level]

    unless level && %(major minor patch).include?(level)
      warn 'Please specify major, minor or patch (e.g., "rake bump[patch]").'
      exit 1
    end

    g = Git.open('.')

    if g.status.changed.count > 0
      warn 'The Git working directory has local modifications. Please commit your work before running this task.'
      exit 1
    end

    if g.current_branch != 'master'
      warn 'Please switch to the master branch before running this task.'
      exit 1
    end

    sh 'bundle exec rake test'
    sh "bundle exec bump #{level} --no-commit"

    g.add(['Gemfile.lock', 'VERSION', 'package.json'])
    g.commit("Bump to version #{version}")
    g.add_tag(version)
  end
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

task :publish do

  if ENV['TRAVIS_BRANCH'] && ENV['TRAVIS_BRANCH'] != 'master'
    warn "Not going to deploy: $TRAVIS_BRANCH is #{ENV['TRAVIS_BRANCH']}, should be master."
    exit 0
  elsif ENV['TRAVIS_PULL_REQUEST'] && ENV['TRAVIS_PULL_REQUEST'] != 'false'
    warn "Not going to deploy: This is a pull request."
    exit 0
  end

  sh 'bundle exec rake build'

  if ENV['TRAVIS_TAG']
    sh 'npm run build'
    sh 'npm pack'
  end

  sh 'bundle exec middleman s3_sync'
end

task test: 'test:all'
task server: [:compile, :view]
task default: :test

%w[INT TERM].each do |signal|
  Signal.trap(signal) do
    puts 'Stopping...'
  end
end
