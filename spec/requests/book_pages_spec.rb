require 'spec_helper'

describe "Book Pages" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "add book" do
    before { visit user_path(user) }
    let(:submit) { "Add book" }

    describe "with invalid information" do

      it "should not create a book" do
        expect { click_button submit }.not_to change(Book, :count)
      end

      describe "error messages" do
        before { click_button submit }
        it { should have_content('error') }
      end
    end

    describe "with valid information" do
      before do
        fill_in 'book_title',  with: "Slaughterhouse-Five"
        fill_in 'book_author', with: "Kurt Vonnegut"
      end

      it "should create a book" do
        expect { click_button submit }.to change(Book, :count).by(1)
      end

      describe "after creating the book" do
        before { click_button submit }
        let(:book_title) { "Slaughterhouse-Five" }

        it { should have_selector('li', text: book_title) }
      end
    end
  end
end
