require 'git'
require 'bump'
require 'fileutils'
require 'rspec/core/rake_task'

class Version

  def self.current
    File.read('VERSION')
  end

  def self.apply!(out=$stdout)
    system 'bundle install --quiet'
    package = JSON.parse(File.read('package.json'))
    package['version'] = current
    File.write('package.json', JSON.pretty_generate(package))
    out.puts  "Applied version #{current}."
  end

  def self.bump!(level, out=$stdout)

    unless level && %(major minor patch).include?(level)
      warn 'Please specify major, minor or patch (e.g., "rake bump[patc h]").'
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

    next_version = Bump::Bump.send(:next_version, Bump::Bump.current, level)
    if g.tags.map { |t| t.name }.include?(next_version)
      warn "A tag named #{next_version} already exists."
      exit 0
    end

    Rake::Task['test'].execute
    Bump::Bump.run(level, commit: false)
    Rake::Task['version:apply'].execute

    g.add(['VERSION', 'Gemfile.lock', 'package.json'])
    g.commit("Bump to version #{current}")
    g.add_tag(current)

    out.puts "Committed and tagged version #{current}."
  end
end