class ProductController < ApplicationController
	layout "kbcore2"
	:scaffold

	def index
	       redirect_to :action => "adv_lookup"
	end
	def list
		@translator = Translations.new
		session[:last_page] = "Product"
	    session[:last_action] = "list"
	
		if (flash["refresh"] == "Y")
		    @this_page = session[:this_page]
		    @family_id = session[:last_id]
		    @part_number = session[:last_part_number]
		    @family = Family.find(@family_id)
		else
		  @screen_name = "Parts List"
		  @family_id = params[:id]
		  @part_number = params[:part_number]
		  @part = Product.find(:first, :conditions => " part_number = '" + @part_number + "'")
	      session[:last_id] = @family_id
	      session[:last_part_number] = @part_number
		  @family = Family.find(@family_id)
		
		  @condition = " family = '" + 
		      @family.mfg_code + 
		      "' and products.display_group = 'A' and products.display_order = " + 
		      @part.display_order.to_s 
		
		  @this_page = PageScroller.new
		  @this_page.set_page_num(1)
		  @this_page.set_tot_items(Product.count_by_sql("select count(*) from products where " + @condition))
		  @this_page.set_page_size(5)
		  @this_page.set_start(1)
		  @this_page.set_conditions(@condition)
		  session[:this_page] = @this_page
		
		end
		flash["refresh"] = "N"
	
	
	
	end
	def adv_lookup

	      print "******Dumping env\n"
     request.env.each do | var |
       print var 
       print "\n"
     end
     
	    @trc = Tracking.new
	    @trc.ip_address = request.env['REMOTE_ADDR']
	    @trc.page_name = 'PART_LOOKUP'
	    @trc.create_date = Date.today
        #@ipLocation = session[:ip_location]    
	    #@trc.City = @ipLocation.city
	    #@trc.Country = @ipLocation.country_long
	    #@trc.Region = @ipLocation.region
	    
	    
	    @customer_id = session[:customer]
        @customer = nil
        if (@customer_id) 
            @customer = Account.find(@customer_id) 
            @trc.user_id = @customer.company_name
        end 
	    @trc.save
	    
		@translator = Translations.new
	
		session[:last_page] = "Product"
	    session[:last_action] = "adv_lookup"
	
		if (flash["refresh"] == "Y")
		    @this_page = session[:this_page]
		else
	      session[:last_action] = "adv_lookup"
		  @screen_name = @translator.get_msg(session[:language], "PARTS LOOKUP")
		
		
		  @this_page = PageScroller.new
		  @this_page.set_page_num(1)
		  @this_page.set_tot_items(0)
		  @this_page.set_page_size(50)
		  @this_page.set_start(1)
		  session[:this_page] = @this_page
		  @this_page.set_conditions(" true = false ")
		
		end
		flash["refresh"] = "N"
	
		@mfrlist = CommonCode.find_by_sql("select distinct upper(mfr) \"code_value\" from products where upper(mfr) != 'ALL' order by mfr ")
		@familylist = CommonCode.find_by_sql("select distinct upper(family) \"code_value\" from products order by family ")
		@part_types = CommonCode.find_by_sql("select distinct upper(classification) \"code_id\", upper(classification) \"code_value\" from products order by classification ")
		@part_names = CommonCode.find_by_sql("select distinct upper(product_type) \"code_id\", upper(product_type) \"code_value\" from products order by product_type ")
	    
	
	end
	
	def assemblies
		if (flash["refresh"] == "Y")
		    @this_page = session[:this_page]
		    @family_id = session[:last_id]
		    @family = Family.find(@family_id)
		else
	      session[:last_action] = "assemblies"
		  @screen_name = "Assemblies List"
		  @family_id = params[:id]
	      session[:last_id] = @family_id
		  @family = Family.find(@family_id)
		
		  @condition = " family = '" + @family.mfg_code + "' and products.display_group = 'B'  "
		
		  @this_page = PageScroller.new
		  @this_page.set_page_num(1)
		  @this_page.set_tot_items(Product.count_by_sql("select count(*) from products where " + @condition))
		  @this_page.set_page_size(5)
		  @this_page.set_start(1)
		  @this_page.set_conditions(@condition)
		  session[:this_page] = @this_page
		
		end
		flash["refresh"] = "N"
	
	
	
	end	
	def miscparts
		if (flash["refresh"] == "Y")
		    @this_page = session[:this_page]
		    @family_id = session[:last_id]
		    @family = Family.find(@family_id)
		else
	      session[:last_action] = "miscparts"
		  @screen_name = "Miscellaneous Parts List"
		  @family_id = params[:id]
	      session[:last_id] = @family_id
		  @family = Family.find(@family_id)
		
		  @condition = " family = '" + @family.mfg_code + "' and products.display_group = 'C'  "
		
		  @this_page = PageScroller.new
		  @this_page.set_page_num(1)
		  @this_page.set_tot_items(Product.count_by_sql("select count(*) from products where " + @condition))
		  @this_page.set_page_size(5)
		  @this_page.set_start(1)
		  @this_page.set_conditions(@condition)
		  session[:this_page] = @this_page
		
		end
		flash["refresh"] = "N"
	
	
	
	end		
	def grouplist

		  @screen_name = "Part Breakdown"
		  @family_id = params[:id]
	      session[:last_id] = @family_id
		  @family = Family.find(@family_id)
		  @prodcnt = Product.count_by_sql("select count(*) from products where family = '" + @family.mfg_code + "'")
		

		  @sql = " family = '" + @family.mfg_code + "'  "		  
		  @product1 = Product.find(:first,
                              :conditions => @sql + " and display_order = 1 ")
          @product2 = Product.find(:first,
                              :conditions => @sql + " and display_order = 2 ")                              
          @product3 = Product.find(:first,
                              :conditions => @sql + " and display_order = 3 ")                              
          @product4 = Product.find(:first,
                              :conditions => @sql + " and display_order = 4 ")                              
          @product5 = Product.find(:first,
                              :conditions => @sql + " and display_order = 5 ")                              
          @product6 = Product.find(:first,
                              :conditions => @sql + " and display_order = 6 ")                              
          @product7 = Product.find(:first,
                              :conditions => @sql + " and display_order = 7 ")                              
          @product8 = Product.find(:first,
                              :conditions => @sql + " and display_order = 8 ")                              
          @product9 = Product.find(:first,
                              :conditions => @sql + " and display_order = 9 ")                              
          @product10 = Product.find(:first,
                              :conditions => @sql + " and display_order = 10 ")              
          @product11 = Product.find(:first,
                              :conditions => @sql + " and display_order = 11 ")              
          @product12 = Product.find(:first,
                              :conditions => @sql + " and display_order = 12 ")              
          @product13 = Product.find(:first,
                              :conditions => @sql + " and display_order = 13 ")              
          @product14 = Product.find(:first,
                              :conditions => @sql + " and display_order = 14 ")              
          @product15 = Product.find(:first,
                              :conditions => @sql + " and display_order = 15 ") 
          @product16 = Product.find(:first,
                              :conditions => @sql + " and display_order = 16 ") 
          @product17 = Product.find(:first,
                              :conditions => @sql + " and display_order = 17 ") 
          @product18 = Product.find(:first,
                              :conditions => @sql + " and display_order = 18 ") 
          @product19 = Product.find(:first,
                              :conditions => @sql + " and display_order = 19 ") 
          @product20 = Product.find(:first,
                              :conditions => @sql + " and display_order = 20 ")
          @product21 = Product.find(:first,
                              :conditions => @sql + " and display_order = 21 ")                                                                                                                                                                                                                                                                                                                                          
          @product22 = Product.find(:first,
                              :conditions => @sql + " and display_order = 22 ")                                                                                                                                                                                                                                                                                                                                          
          @product23 = Product.find(:first,
                              :conditions => @sql + " and display_order = 23 ")                                                                                                                                                                                                                                                                                                                                          
          @product24 = Product.find(:first,
                              :conditions => @sql + " and display_order = 24 ")                                                                                                                                                                                                                                                                                                                                          
          @product25 = Product.find(:first,
                              :conditions => @sql + " and display_order = 25 ")                                                                                                                                                                                                                                                                                                                                          
          @product26 = Product.find(:first,
                              :conditions => @sql + " and display_order = 26 ")                                                                                                                                                                                                                                                                                                                                          
          @product27 = Product.find(:first,
                              :conditions => @sql + " and display_order = 27 ")                                                                                                                                                                                                                                                                                                                                          
          @product28 = Product.find(:first,
                              :conditions => @sql + " and display_order = 28 ")                                                                                                                                                                                                                                                                                                                                          
          @product29 = Product.find(:first,
                              :conditions => @sql + " and display_order = 29 ")                                                                                                                                                                                                                                                                                                                                          
          @product30 = Product.find(:first,
                              :conditions => @sql + " and display_order = 30 ")                                                                                                                                                                                                                                                                                                                                          
                                                                                                                                                                                                                                                                                                                                                                        
	
	end
	
	
	def screen_name
		 @screen_name
	end
	def search
		@translator = Translations.new
	    @part_number = params[:part_number]
	    @description = params[:description]
	    @families = params["families"]	  
	    @part_types = params["part_types"]
	    @part_names = params["part_names"]	    
	    @mfrs = params["mfrs"]  
	    @this_page = session[:this_page]
	    
	    session[:ls_part_number] = @part_number
	    session[:ls_description] = @description
	    session[:ls_families] = @families[0]
	    session[:ls_part_types] = @part_types[0]
	    session[:ls_part_names] = @part_names[0]
	    session[:ls_mfrs] = @mfrs[0]
	    
	
	    
        @whereStr = " true = true "
	    @andCond = " and "
	    if (@part_number && (@part_number.length > 0))
	       @whereStr += @andCond + "products.part_number like '%" + @part_number + "%' "
	       @andCond = " and "
	    end
	    if (@description && (@description.length > 0))
	      @whereStr += @andCond + "products.id in (select product_id from descriptions where description like '%" + @description + "%') "
	      @andCond = " and "
	    end
	    if (@families[0] && (@families[0] != "ALL"))
	      @whereStr += @andCond + "products.family = '" + (@families[0]) + "' "
	      @andCond = " and "
	    end	   	     	       
	    if (@mfrs[0] && (@mfrs[0] != "ALL"))
	      @whereStr += @andCond + "products.mfr = '" + (@mfrs[0]) + "' "
	      @andCond = " and "
	    end	   	
	    if (@part_types[0] && (@part_types[0] != "ALL"))
	      @whereStr += @andCond + "products.classification = '" + (@part_types[0]) + "' "
	      @andCond = " and "
	    end	   	     	       
	    if (@part_names[0] && (@part_names[0] != "ALL"))
	      @whereStr += @andCond + "products.product_type = '" + (@part_names[0]) + "' "
	      @andCond = " and "
	    end	   	     	       
	         	       



	    @prod_cnt = Product.count_by_sql("select count(*) " +
	    				" from products, descriptions " +
	    				" where  products.id = descriptions.product_id and " + @whereStr )
	    			
	    @this_page = PageScroller.new
		@this_page.set_page_num(1)
		@this_page.set_tot_items(@prod_cnt)
		@this_page.set_page_size(50)
		@this_page.set_start(1)
		@this_page.set_conditions(@whereStr)
		@this_page.set_part_number(@part_number)
		@this_page.set_description(@description)
		session[:this_page] = @this_page
		render(:layout => false)
	end

	def search_product
		@translator = Translations.new
		@part_number = request.raw_post || request.query_string
	    @conditions = "products.part_number like '%" + @part_number + "%' "
		
	    @prod_cnt = Product.count_by_sql("select count(*) " +
	    				" from products, descriptions " +
	    				" where products.id = descriptions.product_id " +
	    				"   and " + @conditions  )
	    			
	    @this_page = PageScroller.new
		@this_page.set_page_num(1)
		@this_page.set_tot_items(@prod_cnt)
		@this_page.set_page_size(10)
		@this_page.set_start(1)
		@this_page.set_conditions(@conditions)
		@this_page.set_part_number(@part_number)
		session[:this_page] = @this_page
		render(:layout => false)
	end
	def search_description
			@translator = Translations.new
		@description = request.raw_post || request.query_string		
	    @conditions = "descriptions.description like '%" + @description + "%' "
		
	    @prod_cnt = Product.count_by_sql("select count(*) " +
	    				" from products, descriptions " +
	    				" where products.id = descriptions.product_id " +
	    				"   and " + @conditions  )
	    			
	    @this_page = PageScroller.new
		@this_page.set_page_num(1)
		@this_page.set_tot_items(@prod_cnt)
		@this_page.set_page_size(10)
		@this_page.set_start(1)
		@this_page.set_conditions(@conditions)
		@this_page.set_description(@description)
		session[:this_page] = @this_page
		render(:layout => false)
	end
	def get_results
			@translator = Translations.new
		@this_page = session[:this_page]
		logger.info("Page size: " + @this_page.page_size.to_s)
		logger.info("Start: " + @this_page.start.to_s)
		if (@this_page.conditions != nil)
		  logger.info("Conditions: " + @this_page.conditions)
		end
		#@sql = "select distinct products.* from products, descriptions where products.id = descriptions.product_id and " + @this_page.conditions + " order by products.part_number, products.mfr, products.family  limit " + @this_page.page_size.to_s + " offset " + (@this_page.start - 1).to_s
	    #@products = Product.find_by_sql(@sql)
	    if ((@this_page.conditions == nil) || (@this_page.conditions.length == 0))
		  @products = Product.find(:all,
								 :order => " products.part_number, products.mfr, products.family",
								 :limit => @this_page.page_size,
								 :offset => (@this_page.start - 1))
	    else
	      @products = Product.find(:all,
	      						 :conditions => @this_page.conditions,
								 :order => " products.part_number, products.mfr, products.family",
								 :limit => @this_page.page_size,
								 :offset => (@this_page.start - 1))
	    
	    end
	    
	
	end
	def show_results
        get_results
		render(:layout => false)
	end
	def show_lookup_results
        get_results
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
	def prev_lookup_page
		@this_page = session[:this_page]
		if (@this_page.page_num > 1)
	      @this_page.set_page_num(@this_page.page_num - 1)
	      @this_page.set_start(@this_page.start - @this_page.page_size)
	    end	
		render(:layout => false)
	end
	def next_lookup_page
		@this_page = session[:this_page]
		if (@this_page.page_num < @this_page.num_pages)
	      @this_page.set_page_num( @this_page.page_num + 1)
	      @this_page.set_start(@this_page.start + @this_page.page_size)
	    end	    
		render(:layout => false)
	end	
	def refresh
			@translator = Translations.new
	    flash["refresh"] = "Y"
		redirect_to :controller => "Product", :action => session[:last_action], :id => session[:last_id]
	end
	def transmissioncore
		
	    session[:last_action] = "transmissioncore"
		@screen_name = "Transmission Cores"
			    
		if (flash["refresh"] == "Y")
		    @this_page = session[:this_page]
		else
			@this_page = PageScroller.new
			@this_page.set_page_num(1)
			@this_page.set_tot_items(Product.count_by_sql("SELECT COUNT(*) FROM products P"))
			@this_page.set_page_size(10)
			@this_page.set_start(1)
			@this_page.set_conditions(" true = true ")
		end
		flash["refresh"] = "N"
		session["page_conditions"] = @this_page.conditions
		@years = Year.find(:all, :order => "YEARID DESC")
		@makes = Make.find(:all, :order => "MAKENAME")
		@models = Model.find(:all, :order => "MODELNAME")
		@families = Category.find(:all, :order => "name")
		
		session[:this_page] = @this_page
	end
	def enginecore
		
	    session[:last_action] = "enginecore"
		@screen_name = "Engine Cores"
			    
		if (flash["refresh"] == "Y")
		    @this_page = session[:this_page]
		else
			@this_page = PageScroller.new
			@this_page.set_page_num(1)
			@this_page.set_tot_items(Product.count_by_sql("SELECT COUNT(*) FROM products P"))
			@this_page.set_page_size(10)
			@this_page.set_start(1)
			@this_page.set_conditions(" true = true ")
		end
		flash["refresh"] = "N"
		session["page_conditions"] = @this_page.conditions
		@years = Year.find(:all, :order => "YEARID DESC")
		@makes = Make.find(:all, :order => "MAKENAME")
		@models = Model.find(:all, :order => "MODELNAME")
		@families = Category.find(:all, :order => "name")
		
		
		session[:this_page] = @this_page
	end	
	def fleet
		
	    session[:last_action] = "fleet"
		@screen_name = "Fleet Parts"
			    
		if (flash["refresh"] == "Y")
		    @this_page = session[:this_page]
		else
			@this_page = PageScroller.new
			@this_page.set_page_num(1)
			@this_page.set_tot_items(Product.count_by_sql("SELECT COUNT(*) FROM products P, product_categories PC, categories C WHERE P.ID = PC.PRODUCT_ID AND PC.CATEGORY_ID = C.ID AND C.NAME = 'Fleet'"))
			@this_page.set_page_size(10)
			@this_page.set_start(1)
			@this_page.set_conditions("products.ID IN (SELECT PC.PRODUCT_ID FROM product_categories PC, categories C WHERE PC.CATEGORY_ID = C.ID AND C.NAME = 'Fleet')")
		end
		flash["refresh"] = "N"
		session["page_conditions"] = @this_page.conditions
		@years = Year.find(:all, :order => "YEARID DESC")
		@makes = Make.find(:all, :order => "MAKENAME")
		@models = Model.find(:all, :order => "MODELNAME")
		
		session[:this_page] = @this_page
	end	
	def marine
		
	    session[:last_action] = "Marine"
		@screen_name = "Marine Parts"
			    
		if (flash["refresh"] == "Y")
		    @this_page = session[:this_page]
		else
			@this_page = PageScroller.new
			@this_page.set_page_num(1)
			@this_page.set_tot_items(Product.count_by_sql("SELECT COUNT(*) FROM products P, product_categories PC, categories C WHERE P.ID = PC.PRODUCT_ID AND PC.CATEGORY_ID = C.ID AND C.NAME = 'Marine'"))
			@this_page.set_page_size(10)
			@this_page.set_start(1)
			@this_page.set_conditions("products.ID IN (SELECT PC.PRODUCT_ID FROM product_categories PC, categories C WHERE PC.CATEGORY_ID = C.ID AND C.NAME = 'Marine')")
		end
		flash["refresh"] = "N"
		session["page_conditions"] = @this_page.conditions
		
		@years = Year.find(:all, :order => "YEARID DESC")
		@makes = Make.find(:all, :order => "MAKENAME")
		@models = Model.find(:all, :order => "MODELNAME")
		
		session[:this_page] = @this_page
	end	
	def performance
		
	    session[:last_action] = "performance"
		@screen_name = "Performance Parts"
			    
		if (flash["refresh"] == "Y")
		    @this_page = session[:this_page]
		else
			@this_page = PageScroller.new
			@this_page.set_page_num(1)
			@this_page.set_tot_items(Product.count_by_sql("SELECT COUNT(*) FROM products P, product_categories PC, categories C WHERE P.ID = PC.PRODUCT_ID AND PC.CATEGORY_ID = C.ID AND C.NAME = 'Performance'"))
			@this_page.set_page_size(10)
			@this_page.set_start(1)
			@this_page.set_conditions("products.ID IN (SELECT PC.PRODUCT_ID FROM product_categories PC, categories C WHERE PC.CATEGORY_ID = C.ID AND C.NAME = 'Performance')")
		end
		flash["refresh"] = "N"
		session["page_conditions"] = @this_page.conditions
		
		@years = Year.find(:all, :order => "YEARID DESC")
		@makes = Make.find(:all, :order => "MAKENAME")
		@models = Model.find(:all, :order => "MODELNAME")
		
		session[:this_page] = @this_page
	end	
	def refresh_models

		@translator = Translations.new
			@selected_makes = params["make"]
			@selected_years = params["year"]
			
			if (@selected_makes == nil) || (@selected_makes.length == 0)
				@selected_makes = "'ALL'"
			end
			if (@selected_years == nil) || (@selected_years.length == 0)
				@selected_years = "'ALL'"
			end			
			
			if (@selected_makes == "'ALL'") && (@selected_years == "'ALL'")
				@models = Model.find(:all,:order => "MODELNAME")
			else
				@whereStr = ""
				if (@selected_years != "'ALL'")
					@whereStr = " AND lv.YEAR = " + @selected_years 
				end
				if (@selected_makes != "'ALL'")
					@whereStr += " AND UPPER(lv.MAKE) = UPPER(" + @selected_makes + ")"
				end
				
				@whereStr = " UPPER(model.MODELNAME) = UPPER(lv.MODEL) " + @whereStr
				
				@models = Model.find_by_sql("SELECT DISTINCT model.* FROM model, lv WHERE " + @whereStr + " ORDER BY model.MODELNAME ")
			end		
			
			

		render(:layout => false)
	end
	def refresh_makes
		@translator = Translations.new

			@selected_years = params["year"]
			
			
			if (@selected_years == "'ALL'")
				@makes = Make.find(:all,:order => "MAKENAME")
			else
				@whereStr = " UPPER(make.MAKENAME) = UPPER(lv.MAKE) AND lv.YEAR = " + @selected_years 
				@makes = Make.find_by_sql("SELECT DISTINCT make.* FROM make, lv WHERE " + @whereStr + " ORDER BY make.MAKENAME ")
			end		
			@models = Model.find(:all,:order => "MODELNAME")
		render(:layout => false)
	end	
	def refresh_mfrs
			@translator = Translations.new
	  @part_type = params[:part_type]
	  if (@part_type == nil) || (@part_type == "")
	    @part_type = "'ALL'" 	  
	  end

	  if (@part_type == "'ALL'")  
			@mfrlist = CommonCode.find_by_sql("select distinct upper(mfr) \"code_id\", upper(mfr) \"code_value\" from products  where upper(mfr) != 'ALL' order by mfr ")
	  else
	    @andStr = ""
	    @whereStr = ""
	    if (@part_type != "'ALL'")
	        @whereStr = " classification = " + @part_type 
	        @andStr = " and "
	    end
	    @mfrlist = CommonCode.find_by_sql("select distinct upper(mfr) \"code_id\", upper(mfr) \"code_value\" from products where " + @whereStr + " and  upper(mfr) != 'ALL' order by upper(mfr) ")
	  end
	  render(:layout => false)
	end		
	def refresh_fams
			@translator = Translations.new
	  @mfr = params[:mfr]
	  @part_type = params[:part_type]	 
	  
	  if (@mfr == nil) || (@mfr == "")
	    @mfr = "'ALL'" 	  
	  end
	  if (@part_type == nil) || (@part_type == "")
	    @part_type = "'ALL'"
	  end
	
	  if (@mfr == "'ALL'") &&  (@part_type == "'ALL'")
			@familylist = CommonCode.find_by_sql("select distinct upper(family) \"code_id\", upper(family) \"code_value\" from products order by family ")
	  else
	    @andStr = ""
	    @whereStr = ""	    
	    if (@mfr != "'ALL'")
	        @whereStr = " mfr = " + @mfr 
	        @andStr = " and "
	    end
	    if (@part_type != "'ALL'")
	        @whereStr += @andStr + " classification = " + @part_type 
	        @andStr = " and "
	    end
	    
	    @familylist = CommonCode.find_by_sql("select distinct upper(family) \"code_id\", upper(family) \"code_value\" from products where " + @whereStr + " order by family ")
	  end
	  render(:layout => false)
	end			

	def refresh_partnames
			@translator = Translations.new
	  @mfr = params[:mfr]
	  @family = params[:family]
	  @part_type = params[:part_type]	 
	  
	  if (@mfr == nil) || (@mfr == "")
	    @mfr = "'ALL'" 	  
	  end
	  if (@family == nil) || (@family == "")
	    @family = "'ALL'"
	  end
	  if (@part_type == nil) || (@part_type == "")
	    @part_type = "'ALL'"
	  end
	
	  if (@mfr == "'ALL'") && (@family == "'ALL'") && (@part_type == "'ALL'")
			@part_names = CommonCode.find_by_sql("select distinct upper(product_type) \"code_id\", upper(product_type) \"code_value\" from products order by product_type ")
	  else
	    @andStr = ""
	    @whereStr = ""	    
	    if (@mfr != "'ALL'")
	        @whereStr = " mfr = " + @mfr 
	        @andStr = " and "
	    end
	    if (@family != "'ALL'")
	        @whereStr += @andStr + " family = " + @family 
	        @andStr = " and "
	    end
	    if (@part_type != "'ALL'")
	        @whereStr += @andStr + " classification = " + @part_type 
	        @andStr = " and "
	    end
	    
	    @part_names = CommonCode.find_by_sql("select distinct upper(product_type) \"code_id\", upper(product_type) \"code_value\" from products where " + @whereStr + " order by product_type ")
	  end
	  render(:layout => false)
	end			
end
