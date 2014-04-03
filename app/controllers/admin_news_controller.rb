class AdminNewsController < ApplicationController
	
	layout "kbcore2"
	def index
		@user_id = session[:user_id]
	    if @user_id == nil
	       session[:next_page] = "AdminMail"	    
	       redirect_to :controller => "Login"
	    end
	    @news_articles = NewsItem.find(:all,:order => "create_date")
	end
	def screen_name
		 "Administration - News"
	end
	def new
		@article = NewsItem.new
	end
	def edit
		@article = NewsItem.find(@params["id"])
	end
	def save
	    @article = NewsItem.new 
	    @article.title = params["title"]
	    @article.text = params["text"]
	    @article.link_in_ticker = params["ticker"]
	    @article.create_date = Date.today
	    @article.save
	    generate_ticker
	    redirect_to :action=> "index"
	end
	def saveEdit
	    @article = NewsItem.find(params["id"]) 
	    @article.title = params["title"]
	    @article.text = params["text"]
	    @article.link_in_ticker = params["ticker"]
	    @article.create_date = Date.today
	    @article.save
	    generate_ticker
	    redirect_to :action=> "index"
	end
	def delete
	    NewsItem.find(params["id"]).destroy
	    generate_ticker
	    redirect_to :action=> "index"
	end
	
	def generate_ticker
		@articles = NewsItem.find(:all, 
		 :order => "create_date",
		 :conditions => " link_in_ticker = 'Y' ")
		@file = File.new("textblock.txt","w")
		@file.print "text=<Font face=\"Verdana\"><B> "
		@articles.each do | art |
			@file.print "<A HREF='/News/show/" + art.id.to_s + "'>" + art.title + "</A> ....... "
		end
		@file.print "</B></FONT>"
		@file.close
	end
		


end
