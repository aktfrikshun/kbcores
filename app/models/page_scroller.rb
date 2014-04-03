class PageScroller
  attr_reader :page_num
  attr_reader :tot_items
  attr_reader :num_pages
  attr_reader :page_size
  attr_reader :start
  attr_reader :items
  attr_reader :conditions
  attr_reader :part_number
  attr_reader :description
  attr_reader :custom_sql
  
  def initialize
  	@page_num = 1
  	@tot_items = 0
  	@page_size = 10
  	@start = 1
  	@items = []
  end
  def set_page_num( inVal )
    @page_num = inVal
  end
  def set_tot_items( inVal )
    @tot_items = inVal
  end 
  def get_num_pages
  	@num_pages = ((tot_items - 1) / page_size) + 1
  end
  def set_num_pages(inVal )
    @num_pages = inVal
  end
  def set_page_size( inVal )
    @page_size = inVal
  end
  def set_start( inVal )
    @start = inVal
  end
  def set_conditions( inVal)
  	@conditions = inVal
  end
  def set_custom_sql( inVal )
    @custom_sql = inVal
  end
  def set_part_number( inVal )
  	@part_number = inVal
  end
  def set_description( inVal )
  	@description = inVal
  end
  

end