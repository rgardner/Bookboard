require 'spec_helper'

describe "Booklist Pages" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "booklist creation" do
    before { visit user_path(user) }

    describe "with invalid information" do

      it "should not create a booklist" do
        expect { click_button "Add List" }.not_to change(Booklist, :count)
      end

      describe "error messages" do
        before { click_button "Add List" }
        it { should have_content('error') }
      end
    end

    describe "with valid information" do

      before { fill_in 'booklist_title', with: "Sample list" }
      it "should create a booklist" do
        expect { click_button "Add List" }.to change(Booklist, :count).by(1)
      end
    end
  end

  describe "booklist destruction" do
    before { FactoryGirl.create(:booklist, user: user) }

    describe "as correct user" do
      before { visit user_path(user) }

      it "should delete a booklist" do
        expect { click_link "delete" }.to change(Booklist, :count).by(-1)
      end
    end
  end

end
