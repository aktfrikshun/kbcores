class DataLoaderController < ApplicationController
  def index

    @cnt = 0
    Category.destroy_all
    ProductCategory.destroy_all
    Product.destroy_all
    Description.destroy_all
    
    File.open("C:\\projects\\kbcore\\db\\TP.csv").each { |line|
      @cnt += 1
      

 
        @lineArr = line.split(",")
        
        logger.debug("Number of items: " + @lineArr.size.to_s)
        @part_number = @lineArr[0].strip
        @part_name = @lineArr[5].strip
        @part_price =  @lineArr[2].strip
        @part_mfr = @lineArr[3].strip
        @part_family = @lineArr[4].strip
        
        @part = Product.find(:first,:conditions => " part_number = '" + @part_number + "'")
        if @part
        
        else
          @part = Product.new
          @part.part_number = @part_number
          @part.save      
          @part = Product.find(:first,:conditions => " part_number = '" + @part_number + "'")
        end
        @part.level_1_price = extract_number(@part_price)
        @part.save
        
        @description = Description.find(:first, :conditions => "product_id = " + @part.id.to_s )
        if @description
        
        else
          @description = Description.new
          @description.product_id = @part.id
          @description.save
          @description = Description.find(:first, :conditions => "product_id = " + @part.id.to_s )
        end
        @description.part_number = @part_number
        @description.description = @part_name
        @description.save
        
        if (@part_family && (@part_family.length > 1))
          @category = Category.find(:first, :conditions => " name = '" + @part_family + "'")
          if @category
          else
            @category = Category.new
            @category.name = @part_family
            @category.save
            @category = Category.find(:first, :conditions => " name = '" + @part_family + "'")
          end
          
          @prod_category = ProductCategory.find(:first, :conditions => " product_id = " + @part.id.to_s + " and category_id = " + @category.id.to_s)
          if @prod_category
          else
            @prod_category = ProductCategory.new
            @prod_category.product_id = @part.id
            @prod_category.category_id = @category.id
            @prod_category.save
          end
        
        
        end
        
        

      
      
    }
    
  end
  
  def extract_number(inVal)
		
	  if (inVal.length <= 1)
	    return inVal
	  end
	  if (inVal[0,1] == "$")
	    return inVal[1,inVal.length]
	  else
	    return inVal
	  end
	end
end


