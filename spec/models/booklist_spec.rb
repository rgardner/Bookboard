require 'spec_helper'

describe Booklist do

  let(:user) { FactoryGirl.create(:user) }
  before { @booklist = user.booklists.build(title: "Example") }

  subject { @booklist }

  it { should respond_to(:title) }
  it { should respond_to(:books) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  its(:user) { should eq user }

  it { should be_valid }

  describe "when user_id is not present" do
    before { @booklist.user_id = nil }
    it { should_not be_valid }
  end

  describe "with blank title" do
    before { @booklist.title = " " }
    it { should_not be_valid }
  end

  describe "with title that is too long" do
    before { @booklist.title = "a" * 61 }
    it { should_not be_valid }
  end
end
