class Year < ActiveRecord::Base
	:scaffold
	def self.table_name()
    	"year"
    end  
end
