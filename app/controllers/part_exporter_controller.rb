class PartExporterController < ApplicationController
  layout "kbcore2", :except => "export"
  def index
    @part_classifications = CommonCode.find_by_sql("select distinct upper(classification) \"code_id\", upper(classification) \"code_value\" from products order by classification ")
  
  end
  def export
    headers['Content-Type'] = "application/vnd.ms-excel"
    headers['Content-Disposition'] = 'attachment; filename="KBCoresPartsCatalog.xls"'
    headers['Cache-Control'] = ''
    @classification = params[:classification]
    @parts = Product.find(:all, :conditions => " classification = '" + @classification.to_s + "'", :order => "part_number ")
  end
  def screen_name
    "Part Exporter" 
  end
end
