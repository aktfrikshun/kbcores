class PartDetailsController < ApplicationController
  layout "kbcore2"
  
  def index
    @rid = params[:rid]
    if @rid == nil
      @rid = session[:rid]
    else
      @rid = @rid.to_i
      session[:rid] = @rid
    end
    @part_id = params[:id] 
    @part = Part.find(:first, :conditions => "id = " + @part_id)
    
    @translator = Translations.new     
    @trc = Tracking.new
    @trc.ip_address = request.env['REMOTE_ADDR']
    @trc.page_name = 'PART_DETAIL'
    @trc.create_date = Date.today
    @trc.part_number = @part.part_no
    
    @trc.save
    @screen_name = "Part Details "
    
  end
  
  def addtocart
    #session[:shopping_cart] = nil
    @products = session[:shopping_cart]
    if @products
      
    else
      @products = {}
    end
    @part_id = params[:id]
    @part = Part.find(@part_id)
    @products[@part.id] = @part
    
    session[:shopping_cart] = @products
    
    redirect_to :controller => "Shopping_Cart"
  end   
end
