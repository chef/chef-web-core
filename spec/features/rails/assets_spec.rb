require 'spec_helper'
require 'rails_helper'

describe 'the set of SASS assets', type: :feature do
  subject { page }

  context 'when @imported as a bundle' do

    before { visit '/assets/all.css' }

    it { is_expected.to have_text('.accordion') }
    it { is_expected.to have_text('.alert-box') }
    it { is_expected.to have_text('.button') }
    it { is_expected.to have_text('code') }
    it { is_expected.to have_text('.f-dropdown') }
    it { is_expected.to have_text('form') }
    it { is_expected.to have_text('.fi-') }
    it { is_expected.to have_text('.label') }
    it { is_expected.to have_text('.logo') }
    it { is_expected.to have_text('.reveal-modal') }
    it { is_expected.to have_text('.side-nav') }
    it { is_expected.to have_text('.tabs') }
    it { is_expected.to have_text('.tabs-content') }
    it { is_expected.to have_text('table') }
    it { is_expected.to have_text('.top-bar') }
    it { is_expected.to have_text('.top-bar-2x .title-area{height:10rem}') }
    it { is_expected.to have_text('.logo-2x object{width:512px;height:120px;pointer-events:none}') }
  end

  context 'when imported individually' do

    before { visit '/assets/just-top-bar.css' }

    it { is_expected.to have_text('.top-bar') }
    it { is_expected.to_not have_text('.accordion') }
  end

  it 'supports the inverse theme' do
    visit '/assets/all-inverse.css'

    is_expected.to have_text('.top-bar.expanded .title-area{background:#3f5364}')
    is_expected.to_not have_text('.top-bar.expanded .title-area{background:#ffffff}')
  end
end

describe 'the set of JavaScript assets', type: :feature do
  subject { page }

  context 'when required as a bundle' do

    before { visit '/assets/all.js' }

    it { is_expected.to have_text('Chef.Web.Core.components.sideNav') }
    it { is_expected.to have_text('Chef.Web.Core.components.topBar') }
  end

  context 'when required individually' do

    before { visit '/assets/just-top-bar.js' }

    it { is_expected.to_not have_text('Chef.Web.Core.components.sideNav') }
  end
end