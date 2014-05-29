require 'middleman'
require 'oc/web/core/middleman'

p OC::Web::Core::Middleman

describe OC::Web::Core::Middleman do
  let(:application) do
    Middleman::Application.server.inst do
      activate :oc_web_core
    end
  end

  describe 'oc_title_tag' do
    context 'with a string argument' do
      subject(:oc_title_tag) { application.oc_title_tag('test') }

      it 'is a title tag with test | Chef' do
        expect(oc_title_tag).to eq '<title>test | Chef</title>'
      end
    end

    context 'with no arguments' do
      subject(:oc_title_tag) { application.oc_title_tag }

      it 'is a title tag with "Chef"' do
        expect(oc_title_tag).to eq '<title>Chef</title>'
      end
    end
  end
end
