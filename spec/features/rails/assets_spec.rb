require 'spec_helper'
require 'rails_helper'

describe 'the set of SASS assets', type: :feature do
  subject { page }

  context 'when @imported as a bundle' do

    before { visit '/assets/application.css' }

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
    it { is_expected.to have_text('.logo-2x svg{width:100%;height:100%;pointer-events:none}') }
  end

  context 'when imported individually' do

    before { visit '/assets/just-top-bar.css' }

    it { is_expected.to have_text('.top-bar') }
    it { is_expected.to_not have_text('.accordion') }
  end
end

describe 'the set of JavaScript assets', type: :feature do
  subject { page }

  context 'when required as a bundle' do

    before { visit '/assets/application.js' }

    it { is_expected.to have_text('Chef.Web.Core.components.sideNav') }
    it { is_expected.to have_text('Chef.Web.Core.components.topBar') }
  end

  context 'when required individually' do

    before { visit '/assets/just-top-bar.js' }

    it { is_expected.to_not have_text('Chef.Web.Core.components.sideNav') }
  end
end
