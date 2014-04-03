class PowerTrainController < ApplicationController
	layout "core"
	def index
	    @translator = Translations.new
		@screen_name = @translator.get_msg(session[:language], "Powertrain")
	end
	def screen_name
		 @screen_name
	end
end
