require 'git'
require 'bump'
require 'fileutils'
require 'spec_helper'
require 'version'

describe Version do
  temp_dir = File.expand_path('./tmp/test-tasks')
  out = $stdout
  g = nil

  before :example do
    g = Git.open(temp_dir)

    g.reset_hard(g.log.last)
    g.tags.each { |t| g.delete_tag(t.name) }
    g.branches.each { |b| b.delete unless b.name == 'master' }

    out = StringIO.new
  end

  describe '.apply!' do

    before do
      @version = Version.apply!(temp_dir, out)
    end

    it 'returns the current version' do
      expect(@version).to eq('0.0.1')
    end

    it 'applies the current version to the bundle' do
      pending("This only ever passed because some gem dependencies had the expected version.")
      expect(File.read("#{temp_dir}/Gemfile.lock")).to match(@version)
    end

    it 'applies the current version to the Node package' do
      expect(JSON.parse(File.read("#{temp_dir}/package.json"))['version']).to eq(@version)
    end

    it 'displays a confirmation message' do
      out.rewind
      expect(out.read).to match("Applied version #{@version}.")
    end
  end

  describe '.bump!' do

    it 'returns the new version' do
      new_version = Version.bump!('patch', temp_dir, out)
      expect(new_version).to eq('0.0.2')
    end

    context 'when called with a proper level' do

      before do
        @new_version = Version.bump!('minor', temp_dir, out)
      end

      it 'writes the new version to the VERSION file' do
        expect(File.read("#{temp_dir}/VERSION")).to eq(@new_version)
      end

      it 'writes the new version to package.json' do
        expect(JSON.parse(File.read("#{temp_dir}/package.json"))['version']).to eq(@new_version)
      end

      it 'writes the new version to the bundle' do
        pending("This only ever passed because some gem dependencies had the expected version.")
        expect(File.read("#{temp_dir}/Gemfile.lock")).to match("chef-web-core (#{@new_version})")
      end

      it 'creates a new Git commit' do
        expect(g.log.first.message).to match(@new_version)
      end

      it 'creates a new tag' do
        expect(g.tags.last.name).to eq(@new_version)
      end
    end

    context 'when called without a level' do

      it 'warns' do
        Version.bump!(nil, temp_dir, out)
        out.rewind
        expect(out.read).to match('Please specify major, minor or patch')
      end
    end

    context 'when called with an invalid level' do

      it 'warns' do
        Version.bump!('awesome', temp_dir, out)
        out.rewind
        expect(out.read).to match('Please specify major, minor or patch')
      end
    end

    context 'when the working directory is dirty' do

      before do
        File.write("#{temp_dir}/VERSION", '0.0.9')
      end

      it 'warns' do
        Version.bump!('patch', temp_dir, out)
        out.rewind
        expect(out.read).to match('The Git working directory has local modifications')
      end
    end

    context 'when run on a branch other than master' do

      before do
        g.branch('some-branch').create
        g.checkout('some-branch')
      end

      it 'warns' do
        Version.bump!('patch', temp_dir, out)
        out.rewind
        expect(out.read).to match('Please switch to the master branch')
      end

      after do
        g.checkout('master')
      end
    end

    context 'when bumping would conflict with an existing tag' do

      before do
        g.add_tag('1.0.0')
      end

      it 'warns' do
        Version.bump!('major', temp_dir, out)
        out.rewind
        expect(out.read).to match('A tag named 1.0.0 already exists.')
      end
    end
  end
end
