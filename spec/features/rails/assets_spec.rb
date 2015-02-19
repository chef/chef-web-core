require 'spec_helper'
require 'rails_helper'

describe 'the set of SASS assets', type: :feature do

  context 'when @imported as a bundle' do

    before :each do
      visit '/assets/all.css'
    end

    it 'renders and exposes all CSS components' do
      expect(page).to have_text('.accordion')
      expect(page).to have_text('.alert-box')
      expect(page).to have_text('.button')
      expect(page).to have_text('code')
      expect(page).to have_text('.f-dropdown')
      expect(page).to have_text('form')
      expect(page).to have_text('.fi-')
      expect(page).to have_text('.label')
      expect(page).to have_text('.logo')
      expect(page).to have_text('.reveal-modal')
      expect(page).to have_text('.side-nav')
      expect(page).to have_text('.tabs')
      expect(page).to have_text('.tabs-content')
      expect(page).to have_text('table')
      expect(page).to have_text('.top-bar')
    end

    it 'exposes SASS mixins' do
      expect(page).to have_text('.top-bar-2x .title-area{height:10rem}')
      expect(page).to have_text('.logo-2x object{width:512px;height:120px;pointer-events:none}')
    end
  end

  context 'when imported individually' do

    before :each do
      visit '/assets/top-bar.css'
    end

    it 'renders and exposes only the requested CSS component' do
      expect(page).to have_text('.top-bar')
      expect(page).to_not have_text('.accordion')
    end
  end

  it 'supports the inverse theme' do
    visit '/assets/all-inverse.css'
    expect(page).to have_text('.top-bar.expanded .title-area{background:#3f5364}')
    expect(page).to_not have_text('.top-bar.expanded .title-area{background:#ffffff}')
  end
end

describe 'the set of JavaScript assets', type: :feature do

  it 'exposes the Chef.Web.Core object' do
    visit '/assets/all.js'
    expect(page).to have_text('Chef.Web.Core = {')
  end

  context 'when required as a bundle' do

    before :each do
      visit '/assets/all.js'
    end

    it 'exposes all components to the applicaton' do
      expect(page).to have_text('Chef.Web.Core')
    end
  end

  context 'when required individually' do

    before :each do
      visit '/assets/top-bar.js'
    end

    it 'exposes only the requested asset to the application' do
      pending 'support for individual JavaScript component import'
      fail
    end
  end
end