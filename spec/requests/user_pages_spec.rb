require 'spec_helper'

describe "UserPages" do
  
  describe "User pages" do
    
    subject { page }

    shared_examples_for "all user pages" do
      it { should have_title(full_title(page_title)) }
      it { should have_selector('h1', text: heading) }      
    end

    describe "signup page" do
      before { visit signup_path }
      let(:page_title) { 'Sign up' }
      let(:heading)    { 'Sign up' }

      it_should_behave_like "all user pages"
    end
  end
end
