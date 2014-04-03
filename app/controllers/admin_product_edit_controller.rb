class AdminProductEditController < ApplicationController
  layout "kbcore2"
	:scaffold
  
  def index
    @part_id = params[:id] 
    @part = Part.find(:first, :conditions => "id = " + @part_id)
    @screen_name = "Part Details "
    
  end
  def screen_name
    @screen_name
  end
  def delete
    @part_id = params[:id]
    Part.destroy(@part_id)
    redirect_to :controller =>"Admin_Product", :action => "index"
  end
  def save
    @part_id = params[:id] 
    @part = Part.find(@part_id)		
    if params[:part_type]
      @part.part_type = params[:part_type].upcase
    end
    if params[:part_category]          
      @part.part_category = params[:part_category].upcase
    end
    if params[:description]          
      @part.description = params[:description].upcase
    end
    if params[:manufacturer]          
      @part.manufacturer = params[:manufacturer].upcase
    end
    if params[:cylinders]          
      @part.cylinders = params[:cylinders].upcase
    end
    if params[:liters]          
      @part.liters = params[:liters].upcase
    end
    if params[:ccs]
      @part.ccs = params[:ccs].upcase
    end
    if params[:stroke]          
      @part.stroke = params[:stroke].upcase
    end
    if params[:rod]          
      @part.rod = params[:rod].upcase
    end
    if params[:main]          
      @part.main = params[:main].upcase
    end
    if params[:front_seal_dia]            
      @part.front_seal_dia = params[:front_seal_dia].upcase
    end
    if params[:rear_seal_dia]          
      @part.rear_seal_dia = params[:rear_seal_dia].upcase
    end
    if params[:bore]          
      @part.bore = params[:bore].upcase
    end
    if params[:connect_rod_len]            
      @part.connect_rod_len = params[:connect_rod_len].upcase
    end
    if params[:camshaft]          
      @part.camshaft = params[:camshaft].upcase
    end
    if params[:valves]            
      @part.valves = params[:valves].upcase
    end
    if params[:casting_no]          
      @part.casting_no = params[:casting_no].upcase
    end
    if params[:trans_speed]          
      @part.trans_speed = params[:trans_speed].upcase
    end
    if params[:trans_type]          
      @part.trans_type = params[:trans_type].upcase
    end
    if params[:notes]          
      @part.notes = params[:notes].upcase
    end
    if params[:application_start_yr]          
      @part.application_start_yr = params[:application_start_yr].to_i
    end
    if params[:application_end_yr]          
      @part.application_end_yr = params[:application_end_yr].to_i
    end
    if params[:metal]          
      @part.metal = params[:metal].upcase
    end
    if params[:kb_product_code]          
      @part.kb_product_code = params[:kb_product_code].upcase
    end
    if params[:on_hand]
      @part.on_hand = params[:on_hand]
    end
    if params[:price]
      @part.price = params[:price]
    end
    @part.save
    redirect_to :controller =>"Admin_Product_Edit", :action => "index", :id => @part.id.to_s			
  end
  def picture
    @picture = Picture.find(params[:id])
    send_data(@picture.data,
      :filename => @picture.name,
      :type => @picture.content_type,
      :disposition => "inline")
  end
end
