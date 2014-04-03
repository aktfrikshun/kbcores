    @pictdir = "/home/riverval/rails_apps/kbcores/public/images/parts_from_db/"    
    @products = Product.find(:all, :conditions => " products.id in (select pp.product_id from product_pictures pp,  pictures p where pp.product_id = products.id and p.id = pp.picture_id )")
    @tot_count = @products.size
    @count = 0
    @products.each do | prod | 
                     #logger.debug "Searching for pictures for part " + prod.part_number
      @pictures = Picture.find(:all, :conditions => " id in (select picture_id from product_pictures pp where pp.product_id = " + prod.id.to_s + ")")
      @count = @count + 1
      puts "Processing product  " + prod.part_number + " " + @count.to_s + " of " + @tot_count.to_s
      if @pictures.length > 0
        begin
          Dir.mkdir(@pictdir + prod.part_number )
                         #logger.debug "Made directory " + prod.part_number
        rescue
        end
        @pictures.each do | pict |  
          #begin
            File.open(@pictdir + prod.part_number + "/" + pict.name, 'wb') {|f| f.write(pict.data) }
                puts "    Saving picture " + pict.name
          #rescue
          #end
        end
      end
    end