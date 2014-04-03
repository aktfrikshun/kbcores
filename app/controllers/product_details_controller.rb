class ProductDetailsController < ApplicationController
	layout "kbcore2"
	
	def index
		@part_id = params[:id] || "0"
		@part = Product.find(:first, 
					:conditions => "products.id = " + @part_id)
	    @prod_pictures = ProductPicture.find(:all,:conditions => " rel_type in ('ACTUAL', 'GROUP','DETAIL') and product_id = " + @part_id.to_s, :order => " id ")	

	    @trc = Tracking.new
	    @trc.ip_address = request.env['REMOTE_ADDR']
	    @trc.page_name = 'PART_DETAIL'
	    @trc.create_date = Date.today
	    @trc.part_number = @part.part_number

        #@ipLocation = session[:ip_location]    
	    #@trc.City = @ipLocation.city
	    #@trc.Country = @ipLocation.country_long
	    #@trc.Region = @ipLocation.region
	    
	    
	    @customer_id = session[:customer]
        @customer = nil
        if (@customer_id) 
            @customer = Account.find(@customer_id) 
            @trc.user_id = @customer.company_name
        end 
	    @trc.save
		@screen_name = "Part Details "
	end
	def zoom_image
		@part_id = params[:id] || "0"
		@pict_id = params[:picture]
		@picture = Picture.find(@pict_id)


		@screen_name = ""
	end
	def picture
		@picture = Picture.find(params[:id])
		send_data(@picture.data,
			:filename => @picture.name,
			:type => @picture.content_type,
			:disposition => "inline")
	end
	def addtocart
	   @products = session[:shopping_cart]
	   if @products
	      
	   else
	      @products = {}
	   end
	   @part_id = params[:id]
	   @part = Product.find(@part_id)
	   @products[@part.id] = @part
	   
	   @customeritem = CustomerItem.new
	   @customeritem.product_id = @part.id
	   @customer_id = session[:customer]
       @customer = nil
       if (@customer_id) 
         @customer = Account.find(@customer_id) 
       end 
	   if @customer
	     @customeritem.account_id = @customer.id
	   else
	     @customeritem.account_id = 0
	   end
	   @customeritem.add_date = Date.today
	   @customeritem.save
	   
	   session[:shopping_cart] = @products
	   
	   redirect_to :controller => "Shopping_Cart"
	end 
	def screen_name
		 @screen_name
	end
end
