class UserController < ApplicationController
	layout "kbcore2"
	:scaffold

	def index
		@screen_name = "User Account Administration"
		@user_id = session[:user_id]
	    if @user_id == nil
	       redirect_to :controller => "Login"
	    end
		
	end
	def list
		
		@user_id = session[:user_id]
	    if @user_id == nil
	       redirect_to :controller => "Login"
	    end
	
		@screen_name = "User Account Administration"
		@this_page = PageScroller.new
		@this_page.set_page_num(1)
		@this_page.set_tot_items(User.count())
		@this_page.set_page_size(10)
		@this_page.set_start(1)
		session[:this_page] = @this_page
	end
	def screen_name
		 @screen_name
	end
	def search
		
	    @user_id = params[:user_id]
	    @last_name = params[:last_name]
	    @uiQuery = ""
	    @lnQuery = ""
	    @andCond = ""
	    if (@user_id != nil)
	       @uiQuery = "user_id like '%" + @user_id + "%' "
	       @andCond = " and "
	    end
	    if (@last_name != nil)
	      @lnQuery = @andCond + "last_name like '%" + @last_name + "%' "
	    end


	    @user_cnt = User.count_by_sql("select count(*) " +
	    				" from users " +
	    				" where  " + @uiQuery + @lnQuery )
	    			
	    @this_page = PageScroller.new
		@this_page.set_page_num(1)
		@this_page.set_tot_items(@user_cnt)
		@this_page.set_page_size(10)
		@this_page.set_start(1)
		@this_page.set_conditions(@uiQuery + @lnQuery)
		session[:this_page] = @this_page
		render(:layout => false)
	end
	def search_user_id
		@user_id = request.raw_post || request.query_string
	    @conditions = "user_id like '%" + @user_id+ "%' "
		
	    @user_cnt = User.count_by_sql("select count(*) " +
	    				" from users " +
	    				" where  " + @conditions  )
	    			
	    @this_page = PageScroller.new
		@this_page.set_page_num(1)
		@this_page.set_tot_items(@user_cnt)
		@this_page.set_page_size(10)
		@this_page.set_start(1)
		@this_page.set_conditions(@conditions)
		session[:this_page] = @this_page
		render(:layout => false)
	end
	def search_last_name
		@last_name = request.raw_post || request.query_string		
	    @conditions = "last_name like '%" + @last_name + "%' "
		
	    @user_cnt = User.count_by_sql("select count(*) " +
	    				" from users " +
	    				" where  " + @conditions  )
	    			
	    @this_page = PageScroller.new
		@this_page.set_page_num(1)
		@this_page.set_tot_items(@user_cnt)
		@this_page.set_page_size(10)
		@this_page.set_start(1)
		@this_page.set_conditions(@conditions)
		session[:this_page] = @this_page
		render(:layout => false)
	end
	def show_results
		@this_page = session[:this_page]
		if (@this_page.conditions != nil)
		  logger.info("Conditions: " + @this_page.conditions)
		end
		
		if ((@this_page.conditions == nil) || (@this_page.conditions.length == 0))
		  @users = User.find(:all,
								 :order => "user_id",
								 :limit => @this_page.page_size,
								 :offset => (@this_page.start - 1))
	    else
	      @users = User.find(:all,
	      						 :conditions => @this_page.conditions,
								 :order => "user_id",
								 :limit => @this_page.page_size,
								 :offset => (@this_page.start - 1))
	    
	    end
		render(:layout => false)
	end
	def prev_page
		@this_page = session[:this_page]
		if (@this_page.page_num > 1)
	      @this_page.set_page_num(@this_page.page_num - 1)
	      @this_page.set_start(@this_page.start - @this_page.page_size)
	    end	
		render(:layout => false)
	end
	def next_page
		@this_page = session[:this_page]
		if (@this_page.page_num < @this_page.num_pages)
	      @this_page.set_page_num( @this_page.page_num + 1)
	      @this_page.set_start(@this_page.start + @this_page.page_size)
	    end	    
		render(:layout => false)
	end
	def refresh
		@this_page = session[:this_page]
	end
	def delete
		@id = params[:id] || "0"
		@user = User.find(:first, 
					:conditions => "id = " + @id)	
		@user.destroy	
		redirect_to :controller => "User", :action => "list" 
		
	end
	def save
		
		@id = params[:id]
		if (@id == "")
			@user = User.new
		else
		    @user = User.find(:first, 
					:conditions => "id = " + @id
					)				
		end

		@user.user_id = params["user_id"]
		@user.password = params["password"]
		@user.last_name = params["last_name"]
		@user.first_name = params["first_name"]
		
		@user.save
		
		
		redirect_to :controller =>"User", :action => "list"
		
	
	end
	def new
		@user = User.new
	end
	def edit	
	    @id = params[:id]
	    @user = User.find(:first, 
					:conditions => "id = " + @id
					)				
	end

end
