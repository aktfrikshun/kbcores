class Product < ActiveRecord::Base
  :scaffolding
  attr_reader  :quantity 
  
  def get_quantity
    if @quantity
    else
       @quantity = 1
    end
    return @quantity
  end
  def set_quantity( inVal )
    @quantity = inVal
  end
  
end
