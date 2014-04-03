class AdminProductNewController < ApplicationController
	layout "kbcore2"
	:scaffold

	def index
		@screen_name = "Part Administration - Create new part"
		
		@user_id = session[:user_id]
	    if @user_id == nil
	       session[:next_page] = "Admin_Product_New"	    
	    
	       redirect_to :controller => "Login"
	    end
		
		@part = Product.new
		@part.description = Description.new
		
		@part_types = ProductType.find(:all)
		
		@categories = Category.find(:all)
	end
	def screen_name
		 @screen_name
	end
	def save
		@part = Product.new
		@part.description = Description.new

		@part.part_number = params["part_number"]
		@part.description.description = params["part_description"]
		@part.product_type = params["part_type"]
		@part.save
		
		@part = Product.find(:first, {:conditions => "part_number = '" + @part.part_number + "'" })
		
		
		@categories = params["categories"].collect{|char| char.to_i}
		@categories.each { | aCat |
		    logger.debug("Adding category " + aCat.to_s)
		    @pc = ProductCategory.new
		    @pc.product_id = @part.id
		    @pc.category_id = aCat
		    @pc.save
		}
		
		redirect_to :controller =>"Admin_Product_Edit", :action => "uploadPicture", :id => @part.id.to_s
		
	
	end
end
