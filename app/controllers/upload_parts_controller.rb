class UploadPartsController < ApplicationController
  layout "kbcore2"
  def index
  end
  
  def saveFile
    
    #Remove all parts
    Part.delete_all()
    
    @name = DataFile.save(params[:upload])
    @directory = "public/partsheets"
    @path = File.join(@directory, @name)
    @part_count = 0
    @rowcnt = 0
    File.open(@path).each { |line|
      
      # skip first line  
      @rowcnt = @rowcnt + 1

      if @rowcnt > 1
        @fields = line.chomp().split("\t");
        
        @part_no = @fields[0]
        if @part_no
          @conditions = "parts.part_no = '" + @part_no + "' " 
          
          @part_count = @part_count + 1
 
          @part = Part.find(:first, :conditions => @conditions)
          if @part == nil
            @part = Part.new
            @part.part_no = @part_no.upcase
          end     
          @part.part_no = @part_no.upcase
          if @fields[1]
            @part.part_type = @fields[1].upcase
          end
          if @fields[2]          
            @part.part_category = @fields[2].upcase
          end
          if @fields[3]          
            @part.description = @fields[3].upcase.gsub('"', '')
          end
          if @fields[4]          
            @part.manufacturer = @fields[4].upcase
          end
          if @fields[5]          
            @part.cylinders = @fields[5].upcase
          end
          if @fields[6]          
            @part.liters = @fields[6].upcase
          end
          if @fields[7]
            @part.ccs = @fields[7].upcase
          end
          if @fields[8]          
            @part.stroke = @fields[8].upcase
          end
          if @fields[9]          
            @part.rod = @fields[9].upcase
          end
          if @fields[10]          
            @part.main = @fields[10].upcase
          end
          if @fields[11]            
            @part.front_seal_dia = @fields[11].upcase
          end
          if @fields[12]          
            @part.rear_seal_dia = @fields[12].upcase
          end
          if @fields[13]          
            @part.bore = @fields[13].upcase
          end
          if @fields[14]            
            @part.connect_rod_len = @fields[14].upcase
          end
          if @fields[15]          
            @part.camshaft = @fields[15].upcase
          end
          if @fields[16]            
            @part.valves = @fields[16].upcase
          end
          if @fields[17]          
            @part.casting_no = @fields[17].upcase
          end
          if @fields[18]          
            @part.trans_speed = @fields[18].upcase
          end
          if @fields[19]          
            @part.trans_type = @fields[19].upcase.gsub('"', '') 
          end
          if @fields[20]          
            @part.notes = @fields[20].upcase
          end
          if @fields[21]          
            @part.application_start_yr = @fields[21].to_i
          end
          if @fields[22]          
            @part.application_end_yr = @fields[22].to_i
          end
          if @fields[23]          
            @part.metal = @fields[23].upcase
          end
          if @fields[24]          
            @part.kb_product_code = @fields[24].upcase
          end
          if @fields[25]
            @part.on_hand = @fields[25]
          else
            @part.on_hand = "Call for inventory"
          end
          if @fields[26]
            @part.price = @fields[26]
          else
            @part.price = 0
          end
          @part.save
          
        end
        
      end
      
      
    }
    #rescue
    #  flash[:msg] = "Could not parse spreadsheet"
    #  @results = Array.new
  end
  
  def list
    
  end
  
  def detail
    @part = Part.find(params[:id])    
  end
  
  def screen_name
    "Upload Parts Spreadsheet"
  end
end
