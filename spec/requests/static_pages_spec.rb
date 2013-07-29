require 'spec_helper'

describe "Static pages" do

  subject { page }

  shared_examples_for "all static pages" do
    it { should have_title(full_title(page_title)) }
    it { should have_selector('h1', text: heading) }
  end
  
  describe "Home page" do
    before { visit root_path }
    let(:page_title) { '' }
    let(:heading)    { 'Bookboard' }
    
    it_should_behave_like "all static pages"
    it { should_not have_title('| Home') }
  end

  describe "Help page" do
    before { visit help_path }
    let(:page_title) { 'Help' }
    let(:heading)    { 'Help' }

    it_should_behave_like "all static pages"
  end

  describe "About page" do
    before { visit about_path }
    let(:page_title) { 'About Us'}
    let(:heading)    { 'About Us' }

    it_should_behave_like "all static pages"
  end

  describe "Contact page" do
    before { visit contact_path }
    let(:page_title) { 'Contact' }
    let(:heading)    { 'Contact' }

    it_should_behave_like "all static pages"
  end
end
