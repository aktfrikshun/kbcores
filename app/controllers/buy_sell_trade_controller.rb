class BuySellTradeController < ApplicationController
	layout "kbcore2"
	def index
	    @translator = Translations.new
		@screen_name = @translator.get_msg(session[:language], "Core")
	end
	def screen_name
		 @screen_name
	end
end