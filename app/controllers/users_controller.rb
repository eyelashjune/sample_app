class UsersController < ApplicationController
  def new
    #we must define an @user variable in the controller action corresponding to new.html.erb,
    #i.e., the new action in the Users controller. The form_for helper expects @user to be a User object, and since we’re creating a new user we simply use User.new, as below.
    @user = User.new
  end

  def show
  	#we use the find method on the User model (Section 6.1.4) to retrieve the user from the database
  	#Here we’ve used params to retrieve the user id. When we make the appropriate request /users/1 to the Users controller, params[:id] will be the user id 1
  	#Technically, params[:id] is the string "1", but find is smart enough to convert this to an integer.
  	#Note that the debug information in Figure 7.6 confirms the value of params[:id]: 1 
  	#This is why the code below finds the user with id 1.
  	@user = User.find(params[:id])
  end

  #a POST request to /users is handled by the create action. Our strategy for the create action is to use the form submission to make a new user object using User.new, try (and fail) to save that user, and then render the signup page for possible resubmission.
  def create
    #do not use like @user = User.new(params[:user])
    #Because initializing the entire params hash is extremely dangerous
    #Use strong parameters instead.
    @user = User.new(user_params)
    if @user.save
      #Note that the key :success is a symbol, but embedded Ruby automatically converts it to the string "success" before inserting it into the template.) The reason we iterate through all possible key/value pairs is so that we can include other kinds of flash messages. For example, in Section 8.1.5 we’ll see flash[:error] used to indicate a failed signin attempt.
      #Actually, we’ll use the closely related flash.now, but we’ll defer that subtlety until we need it.
      flash[:success] = "Welcome to the Sample App!"
      #This is because the default behavior for a Rails action is to render the corresponding view, but there is not (nor should there be) a view template corresponding to the create action. Instead, we need to redirect to a different page, and it makes sense for that page to be the newly created user’s profile. Testing that the proper page gets rendered is left as an exercise (Section 7.6); the application code appears in Listing 7.26.
      #Note that we can omit the user_url in the redirect, writing simply redirect_to @user to redirect to the user show page.
      redirect_to @user
    else
      #This listing includes a second use of the render method, which we first saw in the context of partials (Section 5.1.3); as you can see, render works in controller actions as well.
      render 'new'
    end
  end
  
    #Since user_params will only be used internally by the Users controller and need not be exposed to external users via the web, we’ll make it private using Ruby’s private keyword, 
  private

    def user_params
      #Previous versions of Rails used a method called attr_accessible in the model layer to solve this problem, but as of Rails 4.0 the preferred technique is to use so-called strong parameters in the controller layer. This allows us to specify which parameters are required and which ones are permitted. In addition, passing in a raw params hash as above will cause an error to be raised, so that Rails applications are now immune to mass assignment vulnerabilities by default.
      #In the present instance, we want to require the params hash to have a :user attribute, and we want to permit the name, email, password, and password confirmation attributes (but no others). We can accomplish this as follows:
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
