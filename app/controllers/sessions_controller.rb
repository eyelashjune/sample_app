#The elements of signing in and out correspond to particular REST actions of the Sessions controller:
#the signin form is handled by the new action (covered in this section), actually signing in is handled by sending a POST request to the create action
#(Section 8.1 and Section 8.2), and signing out is handled by sending a DELETE request to the destroy action (Section 8.2.6).
#(Recall the association of HTTP verbs with REST actions from Table 7.1.) To get started, we’ll generate a Sessions controller and an integration test for the authentication machinery:
class SessionsController < ApplicationController
	def new
	end

	def create
		#Let’s start by defining a minimalist create action for the Sessions controller (Listing 8.9), which does nothing but render the new view. Submitting the /sessions/new form with blank fields then yields the result shown in Figure 8.5.
		#Carefully inspecting the debug information in Figure 8.5 shows that, as hinted at the end of Section 8.1.3, the submission results in a params hash containing the email and password under the key :session:
		#As a result, params[:session][:email] is the submitted email address and params[:session][:password] is the submitted password.
		#In other words, inside the create action the params hash has all the information needed to authenticate users by email and password.
		#Not coincidentally, we already have exactly the methods we need: the User.find_by_email method provided by Active Record (Section 6.1.4) and the authenticate method provided by has_secure_password (Section 6.3.3).
		render 'new'
	end

	def destroy
	end
end
