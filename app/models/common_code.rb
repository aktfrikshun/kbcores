class CommonCode < ActiveRecord::Base
  attr_reader :mfr_map
  def initialize

  	@mfr_map = {
		"AJ" =>	"AMC/Jeep",
		"DC" =>	"Chrysler/Dodge/Eagle/Plymouth",
		"MM" =>	"Mitsubishi",
		"FO" =>	"Ford/Lincoln/Mercury",
		"MZ" =>	"Mazda",
		"GM" =>	"AM General",
		"OL" =>	"Aurora/Oldsmobile",
		"BU" =>	"Buick",
		"CA" =>	"Cadillac",
		"CH" =>	"Chevrolet",
		"GM" =>	"GM/GMC",
		"PO" =>	"Pontiac",
		"SA" =>	"Saturn",
		"TO" =>	"Toyota/Lexus",
		"DA" =>	"Daihatsu",
		"HO" =>	"Honda/Acura",
		"HY" =>	"Hyundai",
		"IZ" =>	"Isuzu",
		"MZ" =>	"Mazda",
		"NS" =>	"Nissan/Infinity",
		"SU" =>	"Suburu",
		"SZ" =>	"Suzuki",
        "EU" =>	"EUROPEAN IMPORTS",
		"AU" =>	"Audi",
		"BM" =>	"BMW/MINI",
		"FI" =>	"Fiat",
		"JG" =>	"Jaguar",
		"RR" =>	"Land Rover",
		"MG" =>	"MG",
		"MC" =>	"Mercedes-Benz",
		"PU" =>	"Peugeot",
		"PR" =>	"Porche",
		"RN" =>	"Renault",
		"SB" =>	"Saab",
		"VW" =>	"VW",
		"VO" =>	"Volvo",
		"AL" => "ALLISON",
        "DW" => "DAEWOO",
        "CU" => "CUMMINS",
        "IN" => "INTERNATIONAL",
        "JD" => "JOHN DEERE",
        "KI" => "KIA",
        "VW" => "VOLKSWAGEN",
        "YA" => "YAMAHA"
        
		
  	}
  end
  def get_mfr_label( mfrCode )
  
    @retVal = @mfr_map[mfrCode]
    if @retVal
      return ("(" + mfrCode + ") " + @retVal).upcase
    else
      return mfrCode.upcase
    end
  
  end
  
end
