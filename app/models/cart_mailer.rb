class CartMailer < ActionMailer::Base

  def cartconfirm(email,products,name,phone,company,address)
    @subject    = "New KBCores Order List"
    @recipients = 'Justin.Carlisle@kbcores.com' 
    @from		= 'noreply@kbcores.com'
    @body["products"] = products
    @body["name"] = name
    @body["phone"] = phone
    @body["company"] = company
    @body["address"] = address    
  end
  
  
 

end
