require 'git'
require 'fileutils'
require 'rspec/its'
require 'capybara/rspec'

RSpec.configure do |config|
  config.mock_with :rspec
  config.order = 'random'

  temp_dir = File.expand_path('./tmp/test-tasks')

  config.before(:suite) do

    FileUtils.mkdir_p(temp_dir)
    g = Git.init(temp_dir)

    %w(lib VERSION Gemfile Gemfile.lock package.json chef-web-core.gemspec).each do |f|
      FileUtils.cp_r(f, temp_dir)
    end

    File.write("#{temp_dir}/VERSION", '0.0.1')

    Dir.chdir(temp_dir) do
      system 'bundle install --quiet'
    end

    g.add(all: true)
    g.commit('Initial')
  end

  config.after(:suite) do
    FileUtils.rm_rf(temp_dir)
  end
end