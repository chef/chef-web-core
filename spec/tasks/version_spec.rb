require 'git'
require 'spec_helper'
require 'tasks/helpers/version'
require 'bump'

describe Version do
  let(:out) { StringIO.new }

  describe '.apply!' do

    it 'applies the current version to the appropriate local resources' do
      Version.apply!(out)
      out.rewind
      expect(out.read).to match("Applied version #{Version.current}.")
    end
  end

  describe '.bump!' do

    xit 'exits when the working directory is dirty' do
    end

    xit 'exits when run on a branch other than master' do
    end

    xit 'exits when bumping would conflict with an existing tag' do
    end 

    xit 'bumps to the next requested version' do
    end
  end
end