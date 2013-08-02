require 'spec_helper'

describe Book do

  let(:user) { FactoryGirl.create(:user) }
  let(:booklist) { FactoryGirl.create(:booklist, user: user) }
  before do
    @book = booklist.books.build(author: "Example Author", title: "Example Title")
  end

  subject { @book }

  it { should respond_to(:title) }
  it { should respond_to(:author) }
  it { should respond_to(:booklist_id) }
  it { should respond_to(:booklist) }
  its(:booklist) { should eq booklist }
  

  it { should be_valid }

  describe "when booklist_id is not present" do
    before { @book.booklist_id = nil }
    it { should_not be_valid }
  end

  describe "with blank author" do
    before { @book.author = nil }
    it { should_not be_valid }
  end

  describe "with blank title" do
    before { @book.title = nil }
    it { should_not be_valid }
  end
end
