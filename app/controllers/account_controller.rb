class AccountController < ApplicationController
	layout "kbcore2"
	:scaffold

	def index
		@screen_name = "Customer Account Administration"
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
	
		@screen_name = "Customer Account Administration"
		@this_page = PageScroller.new
		@this_page.set_page_num(1)
		@this_page.set_tot_items(Account.count())
		@this_page.set_page_size(10)
		@this_page.set_start(1)
		session[:this_page] = @this_page
	end
	def screen_name
		@screen_name
	end
	def search
		
	    @account_number = params[:account_number]
	    @company_name = params[:company_name]
	    @user = params[:user]
	    @anQuery = ""
	    @cnQuery = ""
	    @andCond = ""
	    if (@account_number != nil)
	       @anQuery = "account_number like '%" + @account_number + "%' "
	       @andCond = " and "
	    end
	    if (@company_name != nil)
	      @cnQuery = @andCond + "company_name like '%" + @company_name + "%' "
	      @andCond = " and "
	    end
	    if (@user != nil)
	      @cnQuery = @andCond + "user like '%" + @user + "%' "
	      @andCond = " and "
	    end	    


	    @account_cnt = Account.count_by_sql("select count(*) " +
	    				" from accounts " +
	    				" where  " + @anQuery + @cnQuery )
	    			
	    @this_page = PageScroller.new
		@this_page.set_page_num(1)
		@this_page.set_tot_items(@account_cnt)
		@this_page.set_page_size(10)
		@this_page.set_start(1)
		@this_page.set_conditions(@anQuery + @cnQuery)
		session[:this_page] = @this_page
		render(:layout => false)
	end
	def search_account
		@account_number = request.raw_post || request.query_string
	    @conditions = "account_number like '%" + @account_number + "%' "
		
	    @account_cnt = Account.count_by_sql("select count(*) " +
	    				" from accounts " +
	    				" where  " + @conditions  )
	    			
	    @this_page = PageScroller.new
		@this_page.set_page_num(1)
		@this_page.set_tot_items(@account_cnt)
		@this_page.set_page_size(10)
		@this_page.set_start(1)
		@this_page.set_conditions(@conditions)
		session[:this_page] = @this_page
		render(:layout => false)
	end
	def search_company_name
		@company_name = request.raw_post || request.query_string		
	    @conditions = "company_name like '%" + @company_name + "%' "
		
	    @account_cnt = Account.count_by_sql("select count(*) " +
	    				" from accounts " +
	    				" where  " + @conditions  )
	    			
	    @this_page = PageScroller.new
		@this_page.set_page_num(1)
		@this_page.set_tot_items(@account_cnt)
		@this_page.set_page_size(10)
		@this_page.set_start(1)
		@this_page.set_conditions(@conditions)
		session[:this_page] = @this_page
		render(:layout => false)
	end
	def search_user
		@user = request.raw_post || request.query_string		
	    @conditions = "user like '%" + @user + "%' "
		
	    @user_cnt = Account.count_by_sql("select count(*) " +
	    				" from accounts " +
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
		  @accounts = Account.find(:all,
								 :order => "account_number, user",
								 :limit => @this_page.page_size,
								 :offset => (@this_page.start - 1))
	    else
	      @accounts = Account.find(:all,
	      						 :conditions => @this_page.conditions,
								 :order => "account_number, user",
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
		@account_id = params[:id] || "0"
		@account = Account.find(:first, 
					:conditions => "id = " + @account_id)	
		@account.destroy	
		redirect_to :controller => "Account", :action => "list" 
		
	end
	def save
		
		@account_id = params[:id]
		if (@account_id == "")
			@account = Account.new
		else
		    @account = Account.find(:first, 
					:conditions => "id = " + @account_id
					)				
		end

		@account.account_number = params["account_number"]
		@account.account_type = params["account_type"]
		@account.company_name = params["company_name"]
		@account.address_line1 = params["address_line1"]
		@account.address_line2 = params["address_line2"]
		@account.city = params["city"]
		@account.state_or_province = params["state"]
		@account.postal_code = params["postal_code"]
		@account.telephone_number = params["telephone_number"]
		@account.fax_number = params["fax_number"]
		@account.email_address = params["email_address"]
		@account.contact_name = params["contact_name"]
		@account.discount = params["discount"]
		@account.user = params["user"]
		@account.password = params["kbpwd"]
		
		@account.save
		
		
		redirect_to :controller =>"Account", :action => "list"
		
	
	end
	def new
		@account = Account.new
	end
	def edit	
	    @account_id = params[:id]
	    @account = Account.find(:first, 
					:conditions => "id = " + @account_id
					)				
	end

end
