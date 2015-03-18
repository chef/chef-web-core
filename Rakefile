require 'rubygems'
require 'fileutils'
require 'bundler'
require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

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
  
  def version
    File.read('VERSION')
  end

  desc 'Apply the version number in VERSION to package.json'
  task :apply do
    sh 'bundle install --quiet'
    package = JSON.parse(File.read('package.json'))
    package['version'] = version
    File.write('package.json', JSON.pretty_generate(package))
    puts  "Applied version #{version}."
  end

  desc 'Increment the version number in VERSION according to Semver'
  task :bump, :level do |t, args|
    require 'git'

    level = args[:level]

    unless level && %(major minor patch).include?(level)
      warn 'Please specify major, minor or patch (e.g., "rake bump[patch]").'
      exit 0
    end

    g = Git.open('.')

    if g.status.changed.count > 0
      warn 'The Git working directory has local modifications. Please commit your work before running this task.'
      exit 0
    end

    if g.current_branch != 'master'
      warn 'Please switch to the master branch before running this task.'
      exit 0
    end

    Rake::Task['test'].execute
    sh "bundle exec bump #{level} --no-commit"

    Rake::Task['version:apply'].execute

    g.add(['Gemfile.lock', 'VERSION', 'package.json'])
    g.commit("Bump to version #{version}")
    g.add_tag(version)
    puts "Committed and tagged version #{version}."
  end
end

namespace :test do
  task all: [:compile, :lib, :middleman, :rails]

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
