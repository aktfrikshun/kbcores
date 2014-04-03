class AdminPicturesController < ApplicationController
	layout "kbcore2"
	:scaffold

	def index
		@screen_name = "Picture Administration"
		@user_id = session[:user_id]
	    if @user_id == nil
	       redirect_to :controller => "Login"
	    end
		
	end
	def list
		
		@user_id = session[:user_id]
	    if @user_id == nil
	       redirect_to :controller => "Login"
	    end
	
		@screen_name = "Picture Administration"
		@this_page = PageScroller.new
		@this_page.set_page_num(1)
		@this_page.set_tot_items(Picture.count())
		@this_page.set_page_size(50)
		@this_page.set_start(1)
		session[:this_page] = @this_page
	end
	def screen_name
		 @screen_name
	end
	def search
		
	    @pict_name = params[:pict_name]
	    @pict_title = params[:pict_title]
	    @pnQuery = " true = true and "
	    @ptQuery = ""
	    @andCond = " and "
	    if (@pict_name != nil) and (@pict_name.length > 0)
	       @pnQuery = "name like '%" + @pict_name + "%' "
	       @andCond = " and "
	    end
	    if (@pict_title != nil) and (@pict_title.length > 0)
	      @ptQuery = @andCond + "comment like '%" + @pict_title + "%' "
	    end


	    @pict_cnt = Picture.count_by_sql("select count(*) " +
	    				" from pictures " +
	    				" where  " + @pnQuery + @ptQuery )
	    			
	    @this_page = PageScroller.new
		@this_page.set_page_num(1)
		@this_page.set_tot_items(@pict_cnt)
		@this_page.set_page_size(50)
		@this_page.set_start(1)
		@this_page.set_conditions(@pnQuery + @ptQuery)
    session[:last_page] = "Admin_Pictures"
		session[:this_page] = @this_page
		render(:layout => false)
	end
	def search_name
		@pict_name = request.raw_post || request.query_string
	    @conditions = "name like '%" + @pict_name + "%' "
		
	    @pict_cnt = Picture.count_by_sql("select count(*) " +
	    				" from pictures " +
	    				" where  " + @conditions  )
	    			
	    @this_page = PageScroller.new
		@this_page.set_page_num(1)
		@this_page.set_tot_items(@pict_cnt)
		@this_page.set_page_size(50)
		@this_page.set_start(1)
		@this_page.set_conditions(@conditions)
		session[:this_page] = @this_page
		render(:layout => false)
	end
	def search_title
		@pict_title = request.raw_post || request.query_string		
	    @conditions = "comment like '%" + @pict_title + "%' "
		
	    @pict_cnt = Picture.count_by_sql("select count(*) " +
	    				" from pictures " +
	    				" where  " + @conditions  )
	    			
	    @this_page = PageScroller.new
		@this_page.set_page_num(1)
		@this_page.set_tot_items(@pict_cnt)
		@this_page.set_page_size(50)
		@this_page.set_start(1)
		@this_page.set_conditions(@conditions)
		session[:this_page] = @this_page
		render(:layout => false)
	end
	def show_results
		@this_page = session[:this_page]
		if (@this_page.conditions != nil)
		  logger.info("Conditions: " + @this_page.conditions)
		end
		
		if ((@this_page.conditions == nil) || (@this_page.conditions.length == 0))
		  @picts = Picture.find(:all,
								 :order => "name",
								 :limit => @this_page.page_size,
								 :offset => (@this_page.start - 1))
	    else
	      @picts = Picture.find(:all,
	      						 :conditions => @this_page.conditions,
								 :order => "name",
								 :limit => @this_page.page_size,
								 :offset => (@this_page.start - 1))
	    
	    end
		render(:layout => false)
	end
	def prev_page
		@this_page = session[:this_page]
		if (@this_page.page_num > 1)
	      @this_page.set_page_num(@this_page.page_num - 1)
	      @this_page.set_start(@this_page.start - @this_page.page_size)
	    end	
		render(:layout => false)
	end
	def next_page
		@this_page = session[:this_page]
		if (@this_page.page_num < @this_page.num_pages)
	      @this_page.set_page_num( @this_page.page_num + 1)
	      @this_page.set_start(@this_page.start + @this_page.page_size)
	    end	    
		render(:layout => false)
	end
	def refresh
		@this_page = session[:this_page]
	end
	def delete
		@pict_id = params[:id] || "0"
		@pict = Picture.find(:first, 
					:conditions => "id = " + @pict_id)	
		@pict.destroy	
		redirect_to :controller => "Admin_Pictures", :action => "refresh" 
		
	end
	def save
		
		@pict_id = params[:id]
		if (@pict_id == "")
			@pict = Picture.new
		else
		    @pict = Picture.find(:first, 
					:conditions => "id = " + @pict_id
					)				
		end

		@pict.comments = params["pict_title"]
		
		@pict.save
		
		
		redirect_to :controller =>"Admin_Pictures", :action => "list"
		
	
	end
	def new
		@picture = Picture.new
	end
	def edit	
	    @pict_id = params[:id]

	    @picture = Picture.find(:first, 
					:conditions => "id = " + @pict_id
					)		
	
	end
	def picture
		@picture = Picture.find(params[:id])
		send_data(@picture.data,
			:filename => @picture.name,
			:type => @picture.content_type,
			:disposition => "inline")
	end
  def download_picture
    @picture = Picture.find(params[:id])
    send_data(@picture.data,
      :filename => @picture.name,
      :type => @picture.content_type,
      :disposition => "inline")
  end
	def show
		@picture = Picture.find(params[:id])
	end
	def savePicture

	    @picture = Picture.new(params[:picture])

	    @picture.comment = params["comment"]
	    if @picture.save
    	else
			flash[:msg] = "Picture file not found or invalid..."
	    end
	    redirect_to :controller =>"Admin_Pictures", :action => "list", :id => @picture.id.to_s	
	end
	def savePictureTitle

		@picture = Picture.find(params[:id])	
      @picture.name = params["name"]
	    @picture.comment = params["comment"]
	    if @picture.save
    	else
			flash[:msg] = "Picture file not found or invalid..."
	    end
	    redirect_to :controller =>"Admin_Pictures", :action => "edit", :id => @picture.id.to_s	
	end

end
