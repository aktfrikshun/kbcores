class TrackingReportController < ApplicationController
  layout "kbcore2"
  def index

     
     @sql = "SELECT distinct yearweek(create_date) from tracking where create_date is not null order by yearweek(create_date) desc "
     @weeks =  ActiveRecord::Base.connection.select_all(@sql)
     
     if session[:this_week] == nil
        @t = Time.now     
        @this_week = @t.strftime("%Y%U")
        session[:this_week] = @this_week
     else
        @this_week = session[:this_week]
     end
     
     @sql = "SELECT page_name, count(*) as hitcount from tracking where yearweek(create_date) = " + @this_week + " group by page_name order by hitcount desc "
     @hitsByPage =  ActiveRecord::Base.connection.select_all(@sql)

     @sql = "SELECT part_number, count(*) as hitcount  from tracking where yearweek(create_date) = " + @this_week + " and part_number is not null group by part_number  order by hitcount desc "
     @hitsByPartNumber =  ActiveRecord::Base.connection.select_all(@sql)

     @sql = "SELECT ip_address, City, Region, Country, count(*) as hitcount  from tracking where yearweek(create_date) = " + @this_week + " group by ip_address, City, Region, Country  order by hitcount desc "
     @hitsByIPAddress =  ActiveRecord::Base.connection.select_all(@sql)
     
     @refetch = false
     @hitsByIPAddress.each do | row |
        if (row["City"] == nil) or (row["City"].length == 0) or (row["City"] == "-")
           #@refetch = true
           #@ipLocation = Ip2location.new
		   #@ipLocation.set_ip(row["ip_address"])
           
           @trc = Tracking.find(:all, :conditions => " ip_address = '" + row['ip_address'] + "'")
           #@trc.each do | row2 |
           #     row2.City = @ipLocation.city
           #     row2.Region = @ipLocation.region
            #    row2.Country = @ipLocation.country_long
           #     row2.save
           #end
        end
     end
     
     if @refetch
          @hitsByIPAddress =  ActiveRecord::Base.connection.select_all(@sql)
     end 

     @sql = "SELECT IFNULL(user_id,'Guest - not logged in') as user, count(*) as hitcount  from tracking where yearweek(create_date) = " + @this_week + " group by user order by hitcount desc "
     @hitsByCustomer =  ActiveRecord::Base.connection.select_all(@sql)

     
  end
  def change_week
     print "*******Change Week:"
     print params[:week]
     session[:this_week] = params[:week]
     redirect_to :action => "index"
  end
  def showrange
       @sql = "SELECT distinct yearweek(create_date) from tracking where create_date is not null order by yearweek(create_date) desc "
       @weeks =  ActiveRecord::Base.connection.select_all(@sql)
       session[:this_week] = nil

       case params["days"]
          when "alldays"
          	@where = " create_date is not null "
          	@date_range = " All data captured... "
          when "30days"
                @where =  " create_date > (CURDATE() - INTERVAL 30 DAY)   "   
                @date_range = " Statistics captured over the last 30 days... "
 
          when "60days"
                @where =  " create_date > (CURDATE() - INTERVAL 60 DAY)   "
                @date_range = " Statistics captured over the last 60 days... "
                
          when "90days"
                @where =  " create_date > (CURDATE() - INTERVAL 90 DAY)   "
                @date_range = " Statistics captured over the last 90 days... "
                
          when "180days"
                @where =  " create_date > (CURDATE() - INTERVAL 180 DAY)   "
                @date_range = " Statistics captured over the last 180 days... "
                
          when "360days"
                @where =  " create_date > (CURDATE() - INTERVAL 360 DAY)   "
                @date_range = " Statistics captured over the last 360 days... "
                

       end
  
       @sql = "SELECT page_name, count(*) as hitcount from tracking where " + @where + " group by page_name order by hitcount desc "
       @hitsByPage =  ActiveRecord::Base.connection.select_all(@sql)
  
       @sql = "SELECT part_number, count(*) as hitcount  from tracking where  " + @where + "  and part_number is not null group by part_number  order by hitcount desc "
       @hitsByPartNumber =  ActiveRecord::Base.connection.select_all(@sql)
  
       @sql = "SELECT ip_address, City, Region, Country, MAX(create_date) as last_access, count(*) as hitcount  from tracking where   " + @where + "  group by ip_address, City, Region, Country  order by hitcount desc "
       @hitsByIPAddress =  ActiveRecord::Base.connection.select_all(@sql)
       
       @refetch = false
       @hitsByIPAddress.each do | row |
        if (row["City"] == nil) or (row["City"].length == 0) or (row["City"] == "-")
       #      @refetch = true
        #     @ipLocation = Ip2location.new
  		#   @ipLocation.set_ip(row["ip_address"])
        #      @trc = Tracking.find(:all, :conditions => " ip_address = '" + row['ip_address'] + "'")
        #     @trc.each do | row2 |
        #          row2.City = @ipLocation.city
        #          row2.Region = @ipLocation.region
         #         row2.Country = @ipLocation.country_long
         #         row2.save
         #    end
          end
       end
     
     if @refetch
          @hitsByIPAddress =  ActiveRecord::Base.connection.select_all(@sql)
     end   
       @sql = "SELECT IFNULL(user_id,'Guest - not logged in') as user, count(*) as hitcount  from tracking where  " + @where + "  group by user order by hitcount desc "
       @hitsByCustomer =  ActiveRecord::Base.connection.select_all(@sql)

       
  end
  def screen_name
    @screen_name = "KBCores Usage Report"
  end
end
