class Ip2location 
  require 'open-uri'
  
  attr_reader  :country_short
  attr_reader  :country_long
  attr_reader  :region
  attr_reader  :city
  attr_reader  :ip_address
  attr_reader  :content
  
  def set_ip( ip_address )
    @ip_address = ip_address
    if @ip_address
  	 @req = open('http://ip2location.dnsalias.com/getip_info.php?ip=' + ip_address ) {
		  | page |
		  @content = page.read()
	 }
	 if @content
	   @attrs = @content.split(",")
	   @attrs.each do | attr |
	     @key = attr.slice(0,attr.index(":"))
	     @value = attr.slice(attr.index(":") + 1, attr.length)

	     case @key
	       when "COUNTRYSHORT"
	          @country_short = @value
	       when "COUNTRYLONG"
	          @country_long = @value
	       when "REGION"
	         @region = @value
	       when "CITY"
	         @city = @value
	     end
	   end
	 
	 end 
	end
	
  end

end
