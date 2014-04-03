class PrinterController < ApplicationController

  def printCart
    @translator = Translations.new    
  		@products = session[:shopping_cart]
  		
  end 
end
