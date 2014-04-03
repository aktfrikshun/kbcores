class HomeController < ApplicationController
	layout "kbcore2"
	def index
	    @translator = Translations.new
		@screen_name = @translator.get_msg(session[:language], "Home")
	end
	def screen_name
		@screen_name
	end
	def viewInEnglish
	    session[:language] = 'EN'
	    redirect_to :action => "index"
	end
	def viewInSpanish
	    session[:language] = 'ES'
	    redirect_to :action => "index"
	end
end
