class AdminMailController < ApplicationController
	layout "kbcore2"
	def index
		@user_id = session[:user_id]
	    if @user_id == nil
	       session[:next_page] = "AdminMail"
	       redirect_to :controller => "Login"
	    end
	    @contact_email = AppSetting.find(:first,
	    	:conditions => " name = 'contact_email' ")
	    @core_pickup_email = AppSetting.find(:first,
	        :conditions => " name = 'core_pickup_email' ")
	end
	def screen_name
		 "Administration - Mail"
	end
	
	def save
		@contact_email = AppSetting.find(:first,
	    	:conditions => " name = 'contact_email' ")

		@val = params["cust_comments"]
		@contact_email.value = @val
		@contact_email.save
		redirect_to :controller => "Admin_Home"
	end
end
