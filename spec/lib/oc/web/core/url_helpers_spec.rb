require 'oc/web/core/url_helpers'

describe Chef::Web::Core::URLHelpers do
  let(:application) { Object.new.extend(described_class) }
  
  describe 'for Chef sites' do
    subject(:corpsite) { application.corpsite }
    subject(:chef_docs) { application.chef_docs }
    subject(:chef_downloads) { application.chef_downloads }
    subject(:learn_chef) { application.learn_chef }
    subject(:chef_manage) { application.chef_manage }
    subject(:supermarket) { application.supermarket }

    it 'makes non-secure URLs' do
      expect(corpsite.non_secure_url).to match(/^http:\/\/www\..+/)
    end

    it 'makes secure URLs' do
      expect(supermarket.secure_url).to match(/^https:\/\/supermarket\..+/)
    end

    it 'makes protocol-relative URLs' do
      expect(learn_chef.protocol_relative_url).to match(/^\/\/learn\..+/)
    end

    it 'makes canonical URLs' do
      expect(chef_docs.canonical_url).to match(/^https:\/\/docs\..+/)
    end

    it 'defines a Corpsite' do
      expect(corpsite).to be
    end

    it 'defines a Docs site' do
      expect(chef_docs).to be
    end

    it 'defines a Downloads site' do
      expect(chef_downloads).to be
    end

    it 'defines a Learn Chef site' do
      expect(learn_chef).to be
    end

    it 'defines a Manage site' do
      expect(chef_manage).to be
    end

    it 'defines a Supermarket' do
      expect(supermarket).to be
    end

    it 'exposes a Site object' do
      site = Chef::Web::Core::URLHelpers::Site.new('www', 'example.com')
      expect(site).to respond_to(:subdomain, :domain, :hostname, :url, :to_s, :secure_url, :non_secure_url, :protocol_relative_url, :canonical_url)
    end
  end

  describe 'for third-party sites' do

    it 'should generate a Facebook URL' do
      expect(application.facebook_url).to match(/facebook/)
    end

    it 'should generate a Twitter URL ' do
      expect(application.twitter_url).to match(/twitter/)
    end

    it 'should generate a LinkedIn URL ' do
      expect(application.linkedin_url).to match(/linkedin/)
    end

    it 'should generate a YouTube URL ' do
      expect(application.youtube_url).to match(/youtube/)
    end
  end
end
