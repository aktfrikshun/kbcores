class AdminProductController < ApplicationController
	layout "kbcore2"
	:scaffold

def index
    
    @rid = params[:rid].to_i
    session[:rid] = @rid
    @trc = Tracking.new
    @trc.ip_address = request.env['REMOTE_ADDR']
    @trc.page_name = 'PART_LOOKUP'
    @trc.create_date = Date.today
    @translator = Translations.new
    
    session[:last_page] = "Admin_Product"
    session[:last_action] = "index"
    
    if (params[:refresh] == "Y") or (session[:this_page] and session[:this_page].conditions and session[:this_page].conditions.length > 0)
      @this_page = session[:this_page]
    else
      session[:last_action] = "index"
      @screen_name = @translator.get_msg(session[:language], "PARTS LOOKUP")
      
      
      @this_page = PageScroller.new
      @this_page.set_page_num(1)
      @this_page.set_tot_items(0)
      @this_page.set_page_size(20)
      @this_page.set_start(1)
      session[:this_page] = @this_page
      @this_page.set_conditions(" true = false ")
      
    end
    
    
    
  end
  def refresh_partcats
    @translator = Translations.new
    @part_type = params[:part_type]
    if (@part_type == nil) || (@part_type == "")
      @part_type = "'ALL'"    
    end
    render(:layout => false)
  end
  
  def search
    @rid = session[:rid]
    @translator = Translations.new
    
    @part_types = params["part_types"]
    @part_cats = params["part_cats"]
    @mfrs = params["mfrs"]  
    @cylinders = params["cylinders"]
    @liters = params["liters"]
    @trans_type = params["trans_type"]
    @casting_number = params["casting_number"]
    @part_no = params["part_no"]    
    @ccs = params["ccs"]
    @parts_with_pictures_only = params["parts_with_pictures_only"]
    
    session[:part_types] = nil
    session[:part_cats] = nil
    session[:mfrs] = nil
    session[:cylinders] = nil
    session[:liters] = nil
    session[:trans_type] = nil
    session[:casting_number] = nil
    session[:part_no] = nil    
    session[:ccs] = nil   
    session[:parts_with_pictures_only] = nil
    
    @this_page = session[:this_page]
    
    @whereStr = " true = true "
    @andCond = " and "
    
    if (@mfrs[0] && (@mfrs[0] != "ALL"))
      session[:mfrs] = @mfrs[0]      
      @whereStr += @andCond + "parts.manufacturer like '%" + @mfrs[0] + "%' "
      @andCond = " and "
    end     
    if (@part_types[0] && (@part_types[0] != "ALL"))
      session[:part_types] = @part_types[0]      
      @whereStr += @andCond + "parts.part_type = '" + @part_types[0] + "' "
      @andCond = " and "
    end                             
    if @parts_with_pictures_only
      session[:parts_with_pictures_only] = @parts_with_pictures_only
      @whereStr += @andCond + " exists (select name from pictures where name like concat(parts.part_no,'-%')) "
      @andCond = " and "
    end
    if (@part_cats[0] && (@part_cats[0] != "ALL"))
      session[:part_cats] = @part_cats[0]      
      @whereStr += @andCond + "parts.part_category = '" + @part_cats[0] + "' "
      @andCond = " and "
    end 
    if (@cylinders[0] && (@cylinders[0] != "ALL"))
      session[:cylinders] = @cylinders[0]      
      @whereStr += @andCond + "parts.cylinders = '" + @cylinders[0] + "' "
      @andCond = " and "
    end   
    if (@liters)
      session[:liters] = @liters       
      @whereStr += @andCond + "parts.liters like '%" + @liters + "%' "
      @andCond = " and "      
    end
    if (@ccs)
      session[:ccs] = @ccs          
      @whereStr += @andCond + "parts.ccs like '%" + @ccs + "%' "
      @andCond = " and "      
    end    
    if (@casting_number)
      session[:casting_number] = @casting_number      
      @whereStr += @andCond + "parts.casting_no like '%" + @casting_number + "%' "
      @andCond = " and "      
    end 
    if (@part_no)
      session[:part_no] = @part_no          
      @whereStr += @andCond + "parts.part_no like '%" + @part_no + "%' "
      @andCond = " and "      
    end     
    if (@trans_type)
      session[:trans_type] = @trans_type      
      @whereStr += @andCond + "parts.trans_type like '%" + @trans_type + "%' "
      @andCond = " and "      
    end    
    
    @prod_cnt = Part.count_by_sql("select count(*) " +
              " from parts " +
              " where " + @whereStr )
    
    @this_page = PageScroller.new
    @this_page.set_page_num(1)
    @this_page.set_tot_items(@prod_cnt)
    @this_page.set_page_size(20)
    @this_page.set_start(1)
    @this_page.set_conditions(@whereStr)
    @this_page.set_part_number(@part_number)
    @this_page.set_description(@description)
    session[:this_page] = @this_page
    render(:layout => false)
  end
  def show_lookup_results
    @rid = session[:rid]
    get_results
    render(:layout => false)
  end 
  def get_results
    @rid = session[:rid]
    @translator = Translations.new
    @this_page = session[:this_page]
    logger.info("Page size: " + @this_page.page_size.to_s)
    logger.info("Start: " + @this_page.start.to_s)
    if (@this_page.conditions != nil)
      logger.info("Conditions: " + @this_page.conditions)
    end
    if ((@this_page.conditions == nil) || (@this_page.conditions.length == 0))
      @products = Part.find(:all,
                 :order => " parts.part_no, parts.manufacturer",
                 :limit => @this_page.page_size,
                 :offset => (@this_page.start - 1))
    else
      @products = Part.find(:all,
                     :conditions => @this_page.conditions,
                 :order => " parts.part_no, parts.manufacturer",
                 :limit => @this_page.page_size,
                 :offset => (@this_page.start - 1))
      
    end
    
    
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
    @rid = params[:rid]
    if @rid == nil
      @rid = session[:rid]
    else
      @rid = @rid.to_i
      session[:rid] = @rid
    end
    @translator = Translations.new
    redirect_to :controller => "Admin_Product", :action => :index, :rid => @rid, :refresh => "Y"
  end  
 def reset_search
    
    session[:part_types] = nil
    session[:part_cats] = nil
    session[:mfrs] = nil
    session[:cylinders] = nil
    session[:liters] = nil
    session[:trans_type] = nil
    session[:casting_number] = nil
    session[:part_no] = nil    
    session[:ccs] = nil    
    session[:this_page] = nil
    session[:parts_with_pictures_only] = nil
    

    redirect_to "/Admin_Product/index"
  end
end
