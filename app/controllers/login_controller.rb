class LoginController < ApplicationController
	layout "kbcore2"

	def index
		
	    @msg = session[:msg]
		@screen_name = "User Login"

	end
	def index_cust
		
	    @msg = session[:msg]
		@screen_name = "Customer Login"

	end	
	def screen_name
	     @screen_name
	end
	def login
		session[:msg] = ""

		@next_page = session[:next_page]
		if (@next_page == nil)
			@next_page = "Home"
		end
		@next_action = session[:next_action]
		if (@next_action == nil)
			@next_action = "index"
	    end
	    @next_id = session[:next_id]
		
		@user_id = params[:user_id]
	    @password = params[:password]
	    
	    @user = User.find(:first,:conditions=> " user_id ='" + @user_id + "'")
	    if (@user == nil)
	      session[:msg] = "Invalid user id..."
	      redirect_to :controller => "Login", :action => "index"
	      return
	    end
		if (@password == @user.password)
		    session[:msg] = ""
		    session[:user_id] = @user_id
		  	redirect_to :controller => @next_page, :action => @next_action, :id => @next_id
		else
		    session[:msg] = "Invalid password..."
		    redirect_to :controller => "Login"
		end
	
end

def logout
  session[:user_id] = nil
  redirect_to "/Admin_Home"
end
	
	def login_cust
		session[:msg] = ""
	
		@next_page = session[:next_page]
		if (@next_page == nil)
			@next_page = "Home"
		end
		@next_action = session[:next_action]
		if (@next_action == nil)
			@next_action = "index"
	    end
	    @next_id = session[:next_id]
		
		@user_id = params[:user_id]
	    @password = params[:password]
	    
	    @account = Account.find(:first,:conditions=> " user ='" + @user_id + "'")
	    if (@account == nil)
	      session[:msg] = "Invalid login..."
	      redirect_to :controller => "Login", :action => "index_cust"
	      return
	    end
		if (@password == @account.password)
		    session[:msg] = ""
		    session[:customer] = @account.id
		  	redirect_to :controller => @next_page, :action => @next_action, :id => @next_id
		else
		    session[:msg] = "Invalid password..."
		    redirect_to :controller => "Login", :action => "index_cust"
		end
	
	end
end
