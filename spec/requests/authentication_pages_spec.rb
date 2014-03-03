require 'spec_helper'

describe "Authentication" do
	
	subject { page }

	describe "signin page" do
		before { visit signin_path }
		
		#Comparing Figure 8.1 with Figure 7.11, we see that the signin form (or, equivalently, the new session form) is similar in appearance to the signup form, except with two fields (email and password) in place of four. As with the signup form, we can test the signin form by using Capybara to fill in the form values and then click the button.
		#In the process of writing the tests, we’ll be forced to design aspects of the application, which is one of the nice side-effects of test-driven development. We’ll start with invalid signin, as mocked up in Figure 8.2.
		describe "with invalid information" do
			before { click_button "Sign in" }

			it { should have_title('Sign in') }
			#The have_selector method checks for a particular selector element
			#which checks for a div tag. In particular, recalling that the dot means “class” in CSS (Section 5.1.2), you might be able to guess that this tests for a div tag with the classes "alert" and "alert-error", like so: <div class="alert alert-error">Invalid...</div>
			it { should have_selector('div.alert.alert-error') }
		end

		#Having written tests for signin failure, we now turn to signin success. The changes we’ll test for are the rendering of the user’s profile page (as determined by the page title, which should be the user’s name), together with three planned changes to the site navigation:
		# 1. The appearance of a link to the profile page
		# 2. The appearance of a “Sign out” link
		# 3. The disappearance of the “Sign in” link
		describe "with valid information" do
			let(:user) { FactoryGirl.create(:user) }
			before do
				fill_in "Email",		with: user.email.downcase
				fill_in "Password",	with: user.password
				click_button "Sign in"
			end

			it { should have_title(user.name) }
			it { should have_link('Profile',		href: user_path(user)) }
			it { should have_link('Sign out',		href: signout_path) }
			it { should_not have_link('Sign in',		href: signin_path) }
		end
	end
end