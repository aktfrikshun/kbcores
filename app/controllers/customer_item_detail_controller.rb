class CustomerItemDetailController < ApplicationController
	layout "kbcore2"

	def index
	    if params[:id] == "0"
	       @customer = Account.new
	       @customer.id = 0
	       @customer.company_name = "Guest"
	       @customer.account_number = "Guest"
	    else
	       @customer = Account.find(params[:id])
	    end 
	   	@screen_name = "Customer Cart Items"
		if (flash["refresh"] == "Y")
		    @this_page = session[:this_page]
		    flash["refresh"] = "N"
		else
 
            @condition = " customer_items.account_id = " + @customer.id.to_s + " and customer_items.product_id in ( select id from products where products.id = customer_items.product_id )"
		
		    @this_page = PageScroller.new
		    @this_page.set_page_num(1)
		    @this_page.set_tot_items(Account.count_by_sql("select count(*) from customer_items where " + @condition))
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
		

	    @items = CustomerItem.find(:all,
		  						 :conditions => @this_page.conditions,
								 :order => " add_date ",
								 :limit => @this_page.page_size,
								 :offset => (@this_page.start - 1))   
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
		redirect_to :controller => "Customer_Item_Detail", :action => "index"
	end	
	def remove_history
	    @customer_id = params[:id]
	    
	    @days = params[:days]
	    
	    @sql = " account_id = " + @customer_id + " and add_date <= ( (CURDATE() + 1) - " + @days + ")"
	    logger.debug("RemoveHistorySQL: " + @sql)
	    CustomerItem.destroy_all(@sql)
	    
	    redirect_to :controller => "Customer_Item_Detail", :action => "index", :id => @customer_id
	end
end
