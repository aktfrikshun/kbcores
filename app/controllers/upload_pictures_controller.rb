class UploadPicturesController < ApplicationController
  layout "kbcore2"
  require 'find'
  # Picture.destroy_all
  
  def base_part_of(file_name)
    name = File.basename(file_name)
    name.gsub(/[^\w._-]/,'')
  end
  
  def index
    dirs = ["/home/riverval/rails_apps/kbcores/image_upload/"]
    excludes = ["CVS","classes","lib","tlds"]
    @i = 0
    @items = Array.new
    for dir in dirs
      Find.find(dir) do |path|
        if FileTest.directory?(path)
          if excludes.include?(File.basename(path))
            Find.prune       # Don't look any further into this directory.
          else
            next
          end
        else
          logger.debug("Path is: " + path)

          if (path.include? ".jpg") || (path.include? ".JPG") || (path.include? ".bmp") || (path.include? ".BMP")
            @name = base_part_of(path)
            logger.debug "Saving picture with name: " + @name
            @picture = Picture.find(:first, :conditions => " name = '" + @name + "'")
            if (@picture)
              @picture.data = File.open(path,"rb").read
              @picture.save
            else            
              @picture = Picture.new
              @picture.name = @name
              @picture.content_type = "image/jpg"
              @picture.data = File.open(path,"rb").read
              @picture.save
            end
            @i = @i + 1
            @items << @picture.name
          end
          begin
            File.delete(path)
          rescue
            logger.error("Cannot delete file: " + path)
          end
          
          p path
        end
      end
      
    end
    logger.debug "Done processing pictures..." + @i.to_s + " files saved."
  end
  
  def screen_name
    "Load Pictures to Database"
  end
  def to_filesystem
    @pictdir = "/home/riverval/rails_apps/kbcores/public/images/parts_from_db/"    
    @products = Product.find(:all, :conditions => " products.id in (select product_id from product_pictures pp where pp.product_id = products.id )")
    @products.each do | prod | 
                     logger.debug "Searching for pictures for part " + prod.part_number
      @pictures = Picture.find(:all, :conditions => " id in (select picture_id from product_pictures pp where pp.product_id = " + prod.id.to_s + ")")
      if @pictures.length > 0
        #begin
          Dir.mkdir(@pictdir + prod.part_number )
                         logger.debug "Made directory " + prod.part_number
        #rescue
        #end
        @pictures.each do | pict |  
          #begin
            File.open(@pictdir + prod.part_number + "/" + pict.name, 'wb') {|f| f.write(pict.data) }
                logger.debug "Saving picture " + pict.name
          #rescue
          #end
        end
      end
    end
  end
end
