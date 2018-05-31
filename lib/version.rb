require 'git'
require 'bump'
require 'fileutils'
require 'json'
require 'rspec/core/rake_task'

class Version

  def self.current(dir='.')
    File.read("#{dir}/VERSION")
  end

  def self.apply!(dir='.', out=$stdout)
    Dir.chdir(dir) do
      system 'bundle install --quiet'
      package = JSON.parse(File.read('package.json'))
      package['version'] = current
      File.write('package.json', JSON.pretty_generate(package))
      out.puts  "Applied version #{current}."
    end
    current(dir)
  end

  def self.bump!(level, dir='.', out=$stdout)
    Dir.chdir(dir) do

      unless level && %(major minor patch).include?(level)
        out.puts 'Please specify major, minor or patch (e.g., "rake bump[patch]").'
        return
      end

      g = Git.open(dir)

      if g.status.changed.count > 0
        out.puts 'The Git working directory has local modifications. Please commit your work before running this task.'
        return
      end

      if g.current_branch != 'master'
        out.puts 'Please switch to the master branch before running this task.'
        return
      end

      next_version = Bump::Bump.send(:next_version, Bump::Bump.current, level)
      if g.tags.map { |t| t.name }.include?(next_version)
        out.puts "A tag named #{next_version} already exists."
        return
      end

      Bump::Bump.run(level, commit: false, bundle: false)
      Version.apply!(dir)

      g.add(['VERSION', 'Gemfile.lock', 'package.json'])
      g.commit("Bump to version #{current}")
      g.add_tag(current)

      out.puts "Committed and tagged version #{current}."
    end
    current(dir)
  end
end
