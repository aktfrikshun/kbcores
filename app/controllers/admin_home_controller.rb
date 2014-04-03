class AdminHomeController < ApplicationController
  layout "kbcore2", :except => "export"
  def index
    @user_id = session[:user_id]
    
    if @user_id == nil
      session[:next_page] = "Admin_Home"
      redirect_to :controller => "Login"
    end
  end
  def screen_name
		 "Administration Home"
  end

end
