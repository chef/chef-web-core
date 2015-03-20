require 'rubygems'
require 'fileutils'
require 'bundler'
require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'version'

Bundler.require

namespace :compile do

  task :hologram do
    sh 'bundle exec hologram -c hologram/config.yml'

    # Seems like there has to be a better way to do this, but
    # the intent is to give the rendered Hologram HTMLs a .erb extension
    # to pull them into the Middleman rendering flow
    Dir.glob('./source/guide/**/*.html').each do |file|
      File.rename(file, "#{file}.erb")
    end
  end

  task :all do
    Rake::Task['compile:hologram'].execute
    sh 'bundle exec middleman build'
  end
end

task :view do
  sh 'MIDDLEMAN_SERVER=1 bundle exec middleman server'
end

namespace :version do

  desc 'Apply the version number in VERSION to package.json'
  task :apply do
    Version.apply!
  end

  desc 'Increment the version number in VERSION according to Semver'
  task :bump, [:level] do |t, args|
    Rake::Task['test'].execute
    Version.bump!(args[:level])
  end
end

namespace :test do
  task all: [:compile, :lib, :middleman, :rails, :tasks]

  desc 'Run only the tests in spec/lib'
  task :lib do
    sh 'bundle exec rspec spec/lib'
  end

  desc 'Run only the tests in spec/features/middleman'
  task :middleman do
    sh 'bundle exec rspec spec/features/middleman'
  end

  desc 'Run only the tests in spec/features/rails'
  task :rails do
    sh 'bundle exec rspec spec/features/rails'
  end

  desc 'Run only the tests in spec/tasks'
  task :tasks do
    sh 'bundle exec rspec spec/tasks'
  end
end

desc 'Compile and deploy the site, build asset packages for distribution'
task :publish do

  if ENV['TRAVIS_BRANCH'] && ENV['TRAVIS_BRANCH'] != 'master'
    warn "Not going to deploy: $TRAVIS_BRANCH is #{ENV['TRAVIS_BRANCH']}, should be master."
    exit 0
  elsif ENV['TRAVIS_PULL_REQUEST'] && ENV['TRAVIS_PULL_REQUEST'] != 'false'
    warn "Not going to deploy: This is a pull request."
    exit 0
  end

  Rake::Task['compile:site'].execute
  sh 'bundle exec middleman s3_sync'

  if ENV['TRAVIS_TAG']
    sh 'npm run build'
    sh 'npm pack'
  end
end

desc 'Run all tests'
task test: 'test:all'

desc 'Compile with Hologram, then build the site'
task compile: 'compile:all' 

desc 'Compile with Hologram, then start the Middleman server' 
task server: ['compile:hologram', :view]

task default: :test

%w[INT TERM].each do |signal|
  Signal.trap(signal) do
    puts 'Stopping...'
  end
end
