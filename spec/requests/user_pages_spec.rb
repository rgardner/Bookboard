require 'spec_helper'

describe "User Pages" do
  
  subject { page }

  shared_examples_for "all user pages" do
    it { should have_title(full_title(page_title)) }
    it { should have_selector('h1', text: heading) }      
  end

  describe "Signup page" do
    before { visit signup_path }
    let(:page_title) { 'Sign up' }
    let(:heading)    { 'Sign up' }

    it_should_behave_like "all user pages"
  end

  describe "Profile page" do
    before { visit user_path(user) }
    let(:page_title) { user.name }
    let(:heading)    { user.name }
    let(:user) { FactoryGirl.create(:user) }

    it_should_behave_like "all user pages"

  end
end
