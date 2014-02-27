class AddIndexToUsersEmail < ActiveRecord::Migration
  def change
  	#we need to fill in its contents with the below line after invoke $ rails generate migration add_index_to_users_email
  	#without it, what can go wrong? Here’s what:
	#1. Alice signs up for the sample app, with address alice@wonderland.com.
	#2. Alice accidentally clicks on “Submit” twice, sending two requests in quick succession.
	#3. The following sequence occurs: request 1 creates a user in memory that passes validation, request 2 does the same, request 1’s user gets saved, request 2’s user gets saved.
	#4. Result: two user records with the exact same email address, despite the uniqueness validation.
  	add_index :users, :email, unique: true
  end
end
