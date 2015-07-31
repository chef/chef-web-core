require 'spec_helper'
require 'middleman_helper'

describe 'the home page', type: :feature do
  before :each do
    visit '/'
  end
  
  it 'has a proper page title' do
    expect(page).to have_title 'Home | Chef Style Guide'
  end

  it 'renders the top bar' do
    the_bar = find('.top-bar')
    expect(the_bar).to have_link('Getting Started')
    expect(the_bar).to have_link('Documentation')
    expect(the_bar).to have_link('Contributing')
  end
end

describe 'the getting-started page', type: :feature do

  let(:current_version) { File.read('VERSION') }

  before :each do
    visit '/getting-started'
  end

  it 'exists' do
    expect(page).to have_content 'Getting Started'
  end

  it 'has a link to download the current version' do
    expect(page).to have_link "Chef Style #{current_version}"
  end
end

describe 'the contributing page', type: :feature do
  before :each do
    visit '/contributing'
  end

  it 'exists' do
    expect(page).to have_content 'Contributing'
  end
end

describe 'the brand-guidelines page', type: :feature do
  before :each do
    visit '/branding'
  end

  it 'exists' do
    expect(page).to have_content 'Brand Guidelines'
  end

  it 'has a link to download the logo in EPS format' do
    click_link 'Chef logo regular EPS'
    expect(page.status_code).to be(200)
  end

  it 'has a link to download the logo in SVG format' do
    click_link 'Chef logo regular SVG'
    expect(page.status_code).to be(200)
  end

  it 'has a link to download the logo in SVG format' do
    click_link 'Chef logo regular PNG'
    expect(page.status_code).to be(200)
  end

  it 'has a link to download the logo in EPS format' do
    click_link 'Chef logo inverse EPS'
    expect(page.status_code).to be(200)
  end

  it 'has a link to download the logo in SVG format' do
    click_link 'Chef logo inverse SVG'
    expect(page.status_code).to be(200)
  end

  it 'has a link to download the logo in SVG format' do
    click_link 'Chef logo inverse PNG'
    expect(page.status_code).to be(200)
  end

  it 'has a link to download the logo in EPS format' do
    click_link 'Chef IO logo EPS'
    expect(page.status_code).to be(200)
  end

  it 'has a link to download the logo in SVG format' do
    click_link 'Chef IO logo SVG'
    expect(page.status_code).to be(200)
  end

  it 'has a link to download the logo in SVG format' do
    click_link 'Chef IO logo PNG'
    expect(page.status_code).to be(200)
  end

  it 'has a link to download the logo in EPS format' do
    click_link 'Chef IO logo inverse EPS'
    expect(page.status_code).to be(200)
  end

  it 'has a link to download the logo in SVG format' do
    click_link 'Chef IO logo inverse SVG'
    expect(page.status_code).to be(200)
  end

  it 'has a link to download the logo in SVG format' do
    click_link 'Chef IO logo inverse PNG'
    expect(page.status_code).to be(200)
  end

end

describe 'the presentations page', type: :feature do
  before :each do
    visit '/presentations'
  end

  it 'exists' do
    expect(page).to have_content 'Presentation Templates'
  end
end

describe 'the style-guide home page', type: :feature do
  before :each do
    visit '/guide'
  end

  it 'redirects to the accordion page' do
    expect(page).to have_selector('meta[http-equiv="refresh"][content="0, url=/guide/accordion"]') 
  end
end

describe 'the accordion page', type: :feature do
  before :each do
    visit '/guide/accordion'
  end

  it 'has content' do
    expect(page).to have_content('Accordion')
  end
end
