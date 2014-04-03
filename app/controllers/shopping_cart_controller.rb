class ShoppingCartController < ApplicationController
	layout "kbcore2"
	def index
	  @translator = Translations.new
		@screen_name = @translator.get_msg(session[:language], "View Cart")
		@products = session[:shopping_cart]
		session[:next_page] = "ShoppingCart"
		session[:next_action] = "index"
		@contact = Contact.new
		@contact.set_first_name( session[:contact_first_name])
		@contact.set_last_name( session[:contact_last_name])
		@contact.set_email( session[:contact_email])
		@contact.set_phone( session[:contact_phone]	)					
	end
	def screen_name
		 @screen_name
	end
	def sendCart	
			
		@products = session[:shopping_cart]
 		email = CartMailer.create_cartconfirm("Allen.Taylor@Frikshun.com",@products,session[:cust_name],session[:phone],session[:company],session[:address])
		email.set_content_type("text/html")
		#render(:text => "<pre>" + email.encoded + "</pre>")
		CartMailer.deliver(email)
	end
	def increase_quantity
	  @products = session[:shopping_cart]
    @part = @products.detect {  | prodArr | prodArr[1].id.to_s = params[:id] }
	  @part.set_quantity(@part.get_quantity + 1)
	  session[:products] = @products
	  redirect_to :action => "index"
	end
	def decrease_quantity
	  @products = session[:shopping_cart]
    @part = @products.detect {  | prodArr | prodArr[1].id.to_s = params[:id] }
	  if (@part.get_quantity > 1)
	     @part.set_quantity(@part.get_quantity - 1)
	  end
	  @products[@part.id] = @part
	  session[:products] = @products
	  
	  redirect_to :action => "index"
	
	end
	def delete_product
	  @products = session[:shopping_cart]
    @newProds = {}
    @products.each do | prodArr | 
      if prodArr[1].id.to_s == params[:id]
        #
      else
        @newProds[prodArr[1].id] = prodArr[1]
      end
    end
    session[:shopping_cart] = @newProds
	  redirect_to :action => "index"
	end
	def updateCart
	  @products = session[:shopping_cart]
	  @products.each do | prodArr |
	   prod = prodArr[1]
	    @qtyVal = prod.id.to_s 
      @notesVal = (prod.id.to_s  + "_notes")
	   # logger.debug("Input Value: " + @inputVal)
	    @quantity = params[@qtyVal]
	    prod.set_quantity(@quantity.to_i)
      @notes = params[@notesVal]
      prod.set_notes(@notes)
	    #prod.save
	  end
    session[:cust_name] = params[:cust_name]
    session[:phone] = params[:phone] 
    session[:company] = params[:company]    
    session[:address] = params[:address]    
	  redirect_to :action => "sendCart"
	end
	def previousPage
	   redirect_to :controller => :Part, :action => "refresh"
	end 
	def refresh
	end
	def getContact
	  @contact = Contact.new
	end
end
