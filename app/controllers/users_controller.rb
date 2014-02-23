class UsersController < ApplicationController
  def new
  end

  def show
  	#we use the find method on the User model (Section 6.1.4) to retrieve the user from the database
  	#Here we’ve used params to retrieve the user id. When we make the appropriate request to the Users controller, params[:id] will be the user id 1
  	#Technically, params[:id] is the string "1", but find is smart enough to convert this to an integer.
  	#Note that the debug information in Figure 7.6 confirms the value of params[:id]: 1 
  	#This is why the code below finds the user with id 1.
  	@user = User.find(params[:id])
  end
end
