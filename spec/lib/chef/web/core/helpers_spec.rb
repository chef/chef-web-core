require 'spec_helper'
require 'chef/web/core/asset_helpers'
require 'nokogiri'

describe Chef::Web::Core::AssetHelpers do
  let(:application) { Object.new.extend(described_class) }

  describe 'the chef_logo helper' do

    context 'without any arguments' do
      subject(:chef_logo) { application.chef_logo }

      it 'should render the logo SVG in a div tag' do
        output = Nokogiri::HTML(chef_logo)
        expect(output.css('div.logo > svg').count).to eq(1)
      end
    end

    context 'with an element specified' do
      subject(:chef_logo) { application.chef_logo(:p) }

      it 'should render the SVG logo in a div tag' do
        output = Nokogiri::HTML(chef_logo)
        expect(output.css('p.logo > svg').count).to eq(1)
      end
    end

    context 'with an element and an attributes hash' do
      subject(:chef_logo) { application.chef_logo(:a, :href => '/', :alt => 'Chef Logo') }

      it 'should render the SVG logo in a div tag' do
        output = Nokogiri::HTML(chef_logo)
        expect(output.css("a.logo[href='/'] > svg").count).to eq(1)
        expect(output.css("a.logo[alt='Chef Logo'] > svg").count).to eq(1)
      end
    end

    context 'with an element and a data-attributes hash' do
      subject(:chef_logo) { application.chef_logo(:a, :data => { :'tag-line' => 'Testing' }) }

      it 'should render the SVG logo in a div tag' do
        output = Nokogiri::HTML(chef_logo)
        expect(output.css("a.logo[data-tag-line='Testing'] > svg").count).to eq(1)
      end
    end

  end
end