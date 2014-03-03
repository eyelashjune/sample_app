#The elements of signing in and out correspond to particular REST actions of the Sessions controller:
#the signin form is handled by the new action (covered in this section), actually signing in is handled by sending a POST request to the create action
#(Section 8.1 and Section 8.2), and signing out is handled by sending a DELETE request to the destroy action (Section 8.2.6).
#(Recall the association of HTTP verbs with REST actions from Table 7.1.) To get started, we’ll generate a Sessions controller and an integration test for the authentication machinery:
class SessionsController < ApplicationController
	def new
	end

	def create
	end

	def destroy
	end
end
