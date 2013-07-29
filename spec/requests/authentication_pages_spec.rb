require 'spec_helper'

describe "Authentication" do
  
  subject { page }

  describe "Signin page" do
    before { visit signin_path }

    it { should have_title(full_title('Sign in')) }
    it { should have_selector('h1', text: 'Sign in') }
  end
end
