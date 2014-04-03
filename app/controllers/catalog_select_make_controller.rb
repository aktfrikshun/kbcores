class CatalogSelectMakeController < ApplicationController
	layout "kbcore2"
	def engines
		@screen_name = "Online Catalog - Select Vehicle Make"
		@make_codes = MakeCode.find(:all)
		session[:product_type] = "engines"
	end
	def transmissions
		@screen_name = "Online Catalog - Select Vehicle Make"
		@make_codes = MakeCode.find(:all)
		session[:product_type] = "transmissions"
	end
	def screen_name
		 @screen_name
	end
end
