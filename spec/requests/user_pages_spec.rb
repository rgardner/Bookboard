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

  describe "signup" do
    before { visit signup_path }
    let(:submit) { "Create my account" }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end

      describe "after submission" do
        before { click_button submit }

        it { should have_title(full_title('Sign up')) }
        it "should contain errors" do
          expect(page).to have_selector('div.alert.alert-error', text: 'error')
        end
      end
    end

    describe "with valid information" do
      before do
        fill_in "Name",             with: "Example User"
        fill_in "Email",            with: "user@example.com"
        fill_in "Password",         with: "foobar"
        fill_in "Confirm Password", with: "foobar"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end

      describe "after saving the user" do
        before { click_button submit }
        let(:user) { User.find_by(email: 'user@example.com') }

        it { should have_title(user.name) }
        it { should have_selector('div.alert.alert-success', text: 'Welcome') }
      end
    end
  end

  describe "Profile page" do
    before { visit user_path(user) }
    let(:user) { FactoryGirl.create(:user) }
    let(:page_title) { user.name }
    let(:heading)    { user.name }

    it_should_behave_like "all user pages"

  end
end
