require 'spec_helper'

describe "Book Pages" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "add book" do
    before { visit user_path(user) }
    let(:submit) { "Add book" }

    describe "as wrong user" do
      let(:wrong_user) { FactoryGirl.create(:user) }
      before { visit user_path(wrong_user) }

      it { should_not have_selector('input', text: 'Add book')}
    end

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

  describe "book destruction" do
    before { FactoryGirl.create(:book, user: user) }

    describe "as correct user" do
      before { visit user_path(user) }

      it "should delete a book" do
        expect { click_link "delete" }.to change(Book, :count).by(-1)
      end
    end
  end
end
