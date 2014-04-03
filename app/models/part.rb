class Part < ActiveRecord::Base
    attr_reader  :quantity 
    attr_reader  :notes
  
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
  
  def get_notes
    return @notes
  end
  def set_notes( inVal )
    @notes = inVal
  end
  
end
