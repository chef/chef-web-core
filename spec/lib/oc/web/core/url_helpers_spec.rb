require 'oc/web/core/url_helpers'

describe Chef::Web::Core::URLHelpers do
  let(:application) { Object.new.extend(described_class) }
  
  describe 'for Chef sites' do
    subject(:corpsite_host) { application.corpsite_host }
    subject(:docs_host) { application.docs_host }
    subject(:learn_chef_host) { application.learn_chef_host }
    subject(:manage_host) { application.manage_host }
    subject(:supermarket_host) { application.supermarket_host }

    it 'makes non-secure URLs' do
      expect(application.absolute_url_for(corpsite_host)).to match(/^http:\/\/www\..+/)
    end

    it 'makes secure URLs' do
      expect(application.secure_absolute_url_for(supermarket_host)).to match(/^https:\/\/supermarket\..+/)
    end

    it 'makes protocol-relative URLs' do
      expect(application.protocol_relative_url_for(learn_chef_host)).to match(/^\/\/learn\..+/)
    end

    it 'makes canonical URLs' do
      expect(application.canonical_url_for(docs_host)).to match(/^https:\/\/docs\..+/)
    end

    it 'defines a corpsite url' do
      expect(application.corpsite_url).to eq(application.canonical_url_for(corpsite_host))
    end

    it 'defines a docs-site url' do
      expect(application.docs_url).to eq(application.canonical_url_for(docs_host))
    end

    it 'defines a learn Chef url' do
      expect(application.learn_chef_url).to eq(application.canonical_url_for(learn_chef_host))
    end

    it 'defines a manage url' do
      expect(application.manage_url).to eq(application.canonical_url_for(manage_host))
    end

    it 'defines a supermarket url' do
      expect(application.supermarket_url).to eq(application.canonical_url_for(supermarket_host))
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
