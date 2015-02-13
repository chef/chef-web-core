require 'spec_helper'
require 'rails_helper'

describe 'the guide page', type: :feature do

  before :each do
    visit '/guide'
  end
  
  it 'renders URL helpers correctly' do
    expect(page).to have_link 'Home', href: 'https://www.chef.io'
    expect(page).to have_link 'Blog', href: 'https://www.chef.io/blog'
    expect(page).to have_link 'Docs', href: 'https://docs.chef.io'
    expect(page).to have_link 'Downloads', href: 'https://downloads.chef.io'
  end
end