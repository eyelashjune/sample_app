require 'spec_helper'

#Note: If you get a deprecation warning like
#[deprecated] I18n.enforce_available_locales will default to true in the future
#you can can get rid of it by editing config/application.rb as adding the following line inside the class SampleApp::Application
#I18n.enforce_available_locales = true

describe User do
	
	before do
		@user = User.new(name: "Example User", email: "user@example.com", 
											password: "foobar", password_confirmation: "foobar")
	end

	subject { @user }

	it { should respond_to(:name) }
	it { should respond_to(:email) }
	it { should respond_to(:password_digest) }
	it { should respond_to(:password) }
	it { should respond_to(:password_confirmation) }

	it { should respond_to(:authenticate) }

	it { should be_valid }

	describe "when name is not present" do
		before { @user.name = " " }
		it { should_not be_valid }
	end

	describe "when email is not present" do
		before { @user.email = " " }
		it { should_not be_valid }
	end

	describe "when name is too long" do
		before { @user.name = "a" * 51 }
		it { should_not be_valid }
	end

	describe "when email format is invalid" do
		it "should be invalid" do
			addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
      	@user.email = invalid_address
      	expect(@user).not_to be_valid
      end
    end
  end

  describe "when email format is valid" do
  	it "should be valid" do
  		addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
  		addresses.each do |valid_address|
  			@user.email = valid_address
  			expect(@user).to be_valid
  		end
  	end
  end

  describe "when email address is already taken" do
  	before do
  		user_with_same_email = @user.dup
  		user_with_same_email.email.upcase!
  		user_with_same_email.save
  	end

  	it { should_not be_valid }
  end

  describe "when email address includes double dots" do
  	before { @user.email = "foo@bar..com" }

  	it { should_not be_valid }
  end

  describe "email address with mixed case" do
  	let(:mixed_case_email) { "Foo@ExAMple.cOm" }

  	it "should be saved as all lower-case" do
  		@user.email = mixed_case_email
  		@user.save
  		expect(@user.reload.email).to eq mixed_case_email.downcase
  	end
  end

  describe "when password is not present" do
  	before do
  		@user.password = " "
  		@user.password_confirmation = " "
  	end

  	it { should_not be_valid }
  end

  describe "when password doesn't match confirmation" do
  	before { @user.password_confirmation = "mismatch" }

  	it { should_not be_valid }
  end

  describe "return value of authenticate method" do
  	before { @user.save }
  	#RSpec’s let method provides a convenient way to create local variables inside tests. The syntax might look a little strange, but its effect is similar to variable assignment. The argument of let is a symbol, and it takes a block whose return value is assigned to a local variable with the symbol’s name. We can use this variable in any of the before or it blocks throughout the rest of the test.
  	let(:found_user) { User.find_by(email: @user.email) }
		
		#eq test for object equality (which uses == to test equality, as seen in Section 4.3.1).
		#authenticate method: If the given password matches the user’s password, it should return the user; otherwise, it should return false.
  	describe "with valid password" do
  		it { should eq found_user.authenticate(@user.password) }
  	end
		
		#As noted in Box 6.3, let memoizes its value, so that the first nested describe block in Listing 6.28 invokes let to retrieve the user from the database using find_by, but the second describe block doesn’t hit the database a second time.
  	describe "with invalid password" do
  		let(:user_for_invalid_password) { found_user.authenticate("invalid") }
  		
  		it { should_not eq user_for_invalid_password }
  		#specify method: This is just a synonym for it, and can be used when writing it would sound unnatural. In this case, it sounds OK to say “it [i.e., the user] should not equal user for invalid password”, but it sounds strange to say “it user for invalid password should be false”; saying “specify: expect user_for_invalid_password object to be false” sounds better.
  		specify { expect(user_for_invalid_password).to be_false }
  	end
  end

  describe "with a password that is too short" do
  	before { @user.password = @user.password_confirmation = "a" * 5 }

  	it { should be_invalid }
  end
end