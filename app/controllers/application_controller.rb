# Filters added to this controller will be run for all controllers in the application.
# Likewise, all the methods added will be available for all controllers.
class ApplicationController < ActionController::Base
 def strip(str,char)
   new_str = ""
   str.each_byte do |byte|
      new_str << byte.chr unless byte.chr == char
   end
   new_str
 end
end