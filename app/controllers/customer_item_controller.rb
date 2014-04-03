class CustomerItemController < ApplicationController
	layout "kbcore2"

	def index
	   	@screen_name = "Customers With Shopping History"
		if (flash["refresh"] == "Y")
		    @this_page = session[:this_page]
		    flash["refresh"] = "N"
		else
 
            @condition = " accounts.id in ( select distinct customer_items.account_id from customer_items ) "
		
		    @this_page = PageScroller.new
		    @this_page.set_page_num(1)
		    @this_page.set_tot_items(Account.count_by_sql("select count(distinct accounts.id) from accounts, customer_items where " + @condition) + 1)
		    @this_page.set_page_size(10)
		    @this_page.set_start(1)
		    @this_page.set_conditions(@condition)
		    session[:this_page] = @this_page
		end
	end
	def screen_name
	     @screen_name
	end
	def show_results
		@this_page = session[:this_page]
		

	    @accounts = Account.find(:all,
		  						 :conditions => @this_page.conditions,
								 :order => " company_name ",
								 :limit => @this_page.page_size,
								 :offset => (@this_page.start - 1)) 
		@guest = Account.new
		@guest.id = 0
		@guest.account_number = "Guest"
		@guest.company_name = "Guest"
		@accounts << @guest 
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
	    flash["refresh"] = "Y"
		redirect_to :controller => "Customer_Item", :action => "index"
	end	
end
