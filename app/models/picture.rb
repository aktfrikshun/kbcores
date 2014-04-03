class Picture < ActiveRecord::Base
	validates_format_of :content_type, :with => /^image/,
		:message => "--- you can only upload images..."
		
	def picture=(picture_field)
		self.name = base_part_of(picture_field.original_filename)
		@picture = Picture.find(:first, :conditions => " name = '" + self.name + "'")
		if (@picture)
		  self.id = @picture.id
		  @picture.destroy
		end
		self.content_type = picture_field.content_type.chomp
		self.data = picture_field.read
	end
	
	def base_part_of(file_name)
		name = File.basename(file_name)
		name.gsub(/[^\w._-]/,'')
	end
end
