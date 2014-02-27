class User < ActiveRecord::Base
	#The reason of using this before_save callback method is that 
	#not all database adapters use case-sensitive indices.
	before_save { self.email.downcase! }

	validates :name,	presence: true,
						length: { maximum: 50 }

	#VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	#following REGEX is more advanced to prevent double-dots in address such as foo@bar..com
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
	validates :email,	presence: true,
						format: { with: VALID_EMAIL_REGEX },
						uniqueness: { case_sensitive: false }

	# has_secure_password command does...
	#	1. (June's inference) Stores given password column into password_digest as a bcrypted password 
	#	2. Adds 'virtual' columns password and password_confirmation
	#	3. Requires the presence of the password
	#	4. Requires password and confirmation match
	#	5. Adds an 'authenticate' method to compare an encrypted password to the password_digest to authenticate users.
	# Source code is at https://github.com/rails/rails/blob/master/activemodel/lib/active_model/secure_password.rb
	has_secure_password  
	#Presence validations for the password and its confirmation are automatically added by has_secure_password.
	validates :password, length: { minimum: 6 }
end
