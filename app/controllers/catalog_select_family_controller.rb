class CatalogSelectFamilyController < ApplicationController
	layout "kbcore2"
	def engines
		@screen_name = "Online Catalog - Select Engine Part Family"
		@make_code_id = params[:id]
		@make_code = MakeCode.find(@make_code_id)
		session[:last_make_code] = @make_code_id
		session[:last_action] = "engines"
		
		@family_groups = FamilyGroup.find(:all, :conditions => " make_code = '" + @make_code.code + "' and fg_type = 'engine' ")
		
	end
	def transmissions
		@screen_name = "Online Catalog - Select Transmission Part Family"
		@make_code_id = params[:id]
		@make_code = MakeCode.find(@make_code_id)
		session[:last_make_code] = @make_code_id
		session[:last_action] = "transmissions"
		
		
		@family_groups = FamilyGroup.find(:all, :conditions => " make_code = '" + @make_code.code + "' and fg_type = 'transmission' ")
		
	end
	def screen_name
		@screen_name
	end
end
