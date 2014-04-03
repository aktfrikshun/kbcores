require "prawn" 
class PdfReportController < ApplicationController
  
  def index
 
    Prawn::Document.generate(docname, :top_margin => 5, :bottom_margin => 5) do |pdf| 
      pdf.text "Hello World"
 
    end
    redirect_to path
  end
private

  def docname
    "#{RAILS_ROOT}/public/docs/tmp/materials_report.pdf"
  end
  
  def path
    return "/docs/tmp/materials_report.pdf"
  end
  

end
