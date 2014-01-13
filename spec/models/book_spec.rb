require 'spec_helper'

describe Book do

  let(:user) { FactoryGirl.create(:user) }
  before do
    @book = user.books.build(title: "Example Title", author: "Example Author")
  end

  subject { @book }

  it { should respond_to(:title) }
  it { should respond_to(:author) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  its(:user) { should eq user }


  it { should be_valid }

  describe "when user_id is not present" do
    before { @book.user_id = nil }
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
