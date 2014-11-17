require 'spec_helper'
require 'oc/web/core/url_helpers'

describe Chef::Web::Core::URLHelpers do
  subject(:app) { Object.new.extend(described_class) }

  before :each do
    stub_const 'ENV', 'CHEF_DOMAIN' => 'chef.io'
  end

  its(:chef_domain)         { is_expected.to eq 'chef.io' }
  its(:chef_server_url)     { is_expected.to eq 'https://api.chef.io' }
  its(:chef_blog_url)       { is_expected.to eq 'https://www.chef.io/blog' }
  its(:chef_docs_url)       { is_expected.to eq 'https://docs.chef.io' }
  its(:chef_downloads_url)  { is_expected.to eq 'https://downloads.chef.io' }
  its(:chef_identity_url)   { is_expected.to eq 'https://id.chef.io/id' }
  its(:chef_manage_url)     { is_expected.to eq 'https://manage.chef.io' }
  its(:chef_sign_up_url)    { is_expected.to eq 'https://manage.chef.io/signup' }
  its(:learn_chef_url)      { is_expected.to eq 'https://learn.chef.io' }
  its(:supermarket_url)     { is_expected.to eq 'https://supermarket.chef.io' }
  its(:chef_facebook_url)   { is_expected.to eq 'https://www.facebook.com/getchefdotcom' }
  its(:chef_twitter_url)    { is_expected.to eq 'https://twitter.com/chef' }
  its(:chef_youtube_url)    { is_expected.to eq 'http://www.youtube.com/user/getchef' }
  its(:chef_linkedin_url)   { is_expected.to eq 'https://www.linkedin.com/groups/Chef-Users-Group-3751378' }

  context 'with a CHEF_DOMAIN set' do
    before :each do
      ENV['CHEF_DOMAIN'] = 'chef.wtf'
    end

    its(:chef_domain)       { is_expected.to eq 'chef.wtf' }
    its(:chef_www_url)      { is_expected.to eq 'https://www.chef.wtf' }
  end

  context 'with no CHEF_DOMAIN set' do
    before :each do
      ENV.delete('CHEF_DOMAIN')
    end

    its(:chef_domain)       { is_expected.to eq 'chef.io' }
    its(:chef_www_url)      { is_expected.to eq 'https://www.chef.io' }
  end

  context 'with a site-specific environment variable set' do
    before :each do
      ENV['CHEF_IDENTITY_URL'] = 'https://identity.opscode.com'
    end

    its(:chef_identity_url) { is_expected.to eq 'https://identity.opscode.com' }
  end
end
