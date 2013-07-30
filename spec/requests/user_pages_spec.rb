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

    describe "as a signed-in user" do
      let(:user) { FactoryGirl.create(:user) }
      before { sign_in user }

      describe "should redirect to the root" do
        before { visit signup_path }
        it { should have_title(user.name) }
        it { should_not have_title('Sign up') }
      end
    end
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

  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    let(:save_changes) { "Save changes" }
    before do
      sign_in(user)
      visit edit_user_path(user)
    end

    describe "page" do
      let(:page_title) { "Edit user" }
      let(:heading)    { "Update your profile" }

      it_should_behave_like "all user pages"
      it { should have_link('change profile picture',
                            href: 'http://gravatar.com/emails') }
      it "should allow user to delete itself" do
        expect do
          click_link "Delete Account"
        end.to change(User, :count).by(-1)
      end
    end

    describe "with invalid information" do
      before { click_button save_changes }

      it { should have_error_message('error') }
    end

    describe "with valid information" do
      let(:new_name)  { "New Name" }
      let(:new_email) { "new@example.com" }
      before do
        fill_in "Name",             with: new_name
        fill_in "Email",            with: new_email
        fill_in "Password",         with: user.password
        fill_in "Confirm Password", with: user.password
        click_button save_changes
      end

      it { should have_title(new_name) }
      it { should have_selector('div.alert.alert-success') }
      it { should have_link('Sign out', href: signout_path) }
      specify { expect(user.reload.name).to eq new_name }
      specify { expect(user.reload.email).to eq new_email }
    end

    describe "forbidden attributes" do
      let(:params) do
        { user: { admin: true, password: user.password,
          password_confirmation: user.password } }
      end
      before { patch user_path(user), params }
      specify { expect(user.reload).not_to be_admin }
    end
  end
end
