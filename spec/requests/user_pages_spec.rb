require 'spec_helper'

describe "User pages" do

  subject { page }

  describe "signup page" do
    before { visit signup_path }

    it { should have_content('Sign up') }
    it { should have_title(full_title('Sign up')) }
  end

  describe "profile page" do
  	#we need to fill in the comment with the appropriate code in order to make the necessary User model object used inside parenthesis 'user_path(user)',
  	#we could use Active Record to create a user with User.create, but experience shows that user factories are a more convenient way to define user objects and insert them in the database.
  	#We’ll be using the factories generated by Factory Girl, a Ruby gem

	#We’ll put all our Factory Girl factories in the file spec/factories.rb, which automatically gets loaded by RSpec.
  	#With the definition in spec/factories.rb, we can create a User factory in the tests using the let command (Box 6.3) and the FactoryGirl method supplied by Factory Girl:
  	let(:user) { FactoryGirl.create(:user) }
  	before { visit user_path(user) }

  	it { should have_content(user.name) }
  	it { should have_title(user.name) }
  end

  #The purpose of our tests is to verify that clicking the signup button results in the correct behavior, creating a new user when the information is valid and not creating a user when it’s invalid.
  #The way to do this is to check the count of users, and under the hood our tests will use the count method available on every Active Record class, including User:
  describe "signup" do
    before { visit signup_path }

    let(:submit) { "Create my account" }

    describe "with invalid information" do
      it "should not create a user" do
        #Note that, as indicated by the curly braces, expect wraps click_button in a block (Section 4.3.2). This is for the benefit of the change method, which takes as arguments an object and a symbol and then calculates the result of calling that symbol as a method on the object both before and after the block. In other words, the code
        expect { click_button submit }.not_to change(User, :count)
        #calculates User.count before and after the execution of click_button "Create my account"
      end

      #Writing tests for the error messages implemented in Listing 7.23.
      describe "after submission" do
        before { click_button submit }

        it { should have_title('Sign up') }
        it { should have_content('error') }
      end
    end

    describe "with valid information" do
      before do
        fill_in "Name",           with: "Example User"
        fill_in "Email",          with: "user@example.com"
        fill_in "Password",       with: "foobar"
        fill_in "Confirmation",   with: "foobar"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count)
      end

      #By writing the test first or by intentionally breaking and then fixing the application code, verify that the tests in Listing 7.32 correctly specify the desired behavior after saving the user in the create action. Listing 7.32 uses the have_selector method introduced in the Chapter 5 exercises (Section 5.6). In this case, we use have_selector to pick out particular CSS classes along with specific HTML tags.
      describe "after saving the user" do
        before { click_button submit }
        let(:user) { User.find_by(email: 'user@example.com') }

        it { should have_title(user.name) }
        it { should have_selector('div.alert.alert-success', text: 'Welcome') }
      end
    end
  end
end
