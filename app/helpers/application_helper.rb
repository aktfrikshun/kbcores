# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def get_part_types
    @part_types = ["Engine", "Engine Part", "Transmission", "Transmission Part"]
    return @part_types
  end
  
  def get_part_categories
    @part_categories = ["Long Block","Short Block", "Bare Block","Camshaft","Connecting Rod","Crankshaft","Cylinder Head","Torque Converter","Transmission","Bell Housing","Case","Center Support","Chain","Differentials","Drum","Governors","Hub","Pinion Shaft","Planetary","Pump","Ring Gear","Shaft","Sprag","Sprocket/Gear","Sun Shell","Sungear","Tail Housing","Valve Body"]    
    return @part_categories
  end
  
  def get_part_categories_for_type(part_type)
    if part_type == "'ALL'"
      return ["ALL", "Long Block","Short Block", "Bare Block","Camshaft","Connecting Rod","Crankshaft","Cylinder Head","Torque Converter","Transmission","Bell Housing","Case","Center Support","Chain","Differentials","Drum","Governors","Hub","Pinion Shaft","Planetary","Pump","Ring Gear","Shaft","Sprag","Sprocket/Gear","Sun Shell","Sungear","Tail Housing","Valve Body"] 
    end
    if part_type == "'ENGINE'"
       return ["ALL","Long Block","Short Block", "Bare Block"]
   end
   if part_type == "'ENGINE PART'"
     return ["ALL","Camshaft","Connecting Rod","Crankshaft","Cylinder Head","Torque Converter"]
     
   end
   if part_type == "'TRANSMISSION'"
     return ["ALL","Transmission"]
   end
   if part_type == "'TRANSMISSION PART'"
      return ["ALL","Bell Housing","Case","Center Support","Chain","Differentials","Drum","Governors","Hub","Pinion Shaft","Planetary","Pump","Ring Gear","Shaft","Sprag","Sprocket/Gear","Sun Shell","Sungear","Tail Housing","Valve Body"]
   end
   return [part_type] 
  end
  
  def get_mfrs
    @mfrs = ["Allison","AMC",
"Audi",
"BMW",
"Buick",
"Cadillac",
"Chevrolet",
"Chrysler",
"Cummins",
"Daewoo",
"Daihatsu",
"Dodge",
"Ford",
"Geo",
"GM",
"Honda",
"Hyundai",
"International",
"Isuzu",
"Jaguar",
"Jeep",
"John Deere",
"Kia",
"Lexus",
"Lincoln",
"Mazda",
"Mercedes",
"Mercury",
"Mitsubishi",
"Nissan",
"Oldsmobile",
"Opel",
"Peugeot",
"Plymouth",
"Pontiac",
"Range Rover",
"Renault",
"Saab",
"Saturn",
"Subaru",
"Suzuki",
"Toyota",
"VM Motori",
"Volkswagon",
"Volvo",
"Yamaha"]
    return @mfrs
  end
  def get_cylinders
    @cylinders = ["I3",
"I4",
"I5",
"I6",
"V6",
"V8",
"V10",
"V12"
]
    return @cylinders
  end
end
