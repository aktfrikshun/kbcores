class ContactUsController < ApplicationController
	layout "kbcore2"
	def index
		@translator = Translations.new
		@screen_name = @translator.get_msg(session[:language], "Contact Us")
	
		@contact = find_contact
		@msg = "Contact Us"
	end
	def screen_name
	   return @screen_name
	end
	def find_contact
		session[:contact] ||= Contact.new
	end
	def sendContact	
		@contact_hash = params[:contact]
		@contact = Contact.new
		@contact.set_first_name(@contact_hash['first_name'])
    	@contact.set_last_name(@contact_hash['last_name'])
    	@contact.set_title(@contact_hash['title'])    
    	@contact.set_company(@contact_hash['company'])    
    	@contact.set_email(@contact_hash['email'])
    	@contact.set_address1(@contact_hash['address1'])
    	@contact.set_address2(@contact_hash['address2'])
    	@contact.set_city(@contact_hash['city'])
    	@contact.set_state(@contact_hash['state'])
    	@contact.set_zip_code(@contact_hash['zip_code'])
    	@contact.set_phone(@contact_hash['phone'])
    	@contact.set_comments(@contact_hash['comments'])
 		email = ContactMailer.create_confirm(@contact)
		email.set_content_type("text/html")
		#render(:text => "<pre>" + email.encoded + "</pre>")
		ContactMailer.deliver(email)
	end

end
