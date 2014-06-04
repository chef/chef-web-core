require 'oc/web/core/helpers'

describe OC::Web::Core::Helpers do
  let(:application) { Object.new.extend(described_class) }

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
