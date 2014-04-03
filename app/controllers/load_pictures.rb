class LoadPictures 
  require 'find'
  # Picture.destroy_all
  
  	def base_part_of(file_name)
		name = File.basename(file_name)
		name.gsub(/[^\w._-]/,'')
	end
 
  def index
    dirs = ["/usr/local/projects/kbcore/public/images/parts/"]
    excludes = ["CVS","classes","lib","tlds"]
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
            end
      
        p path
      end
    end
  end
end

end


