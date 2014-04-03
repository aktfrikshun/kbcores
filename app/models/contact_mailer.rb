class ContactMailer < ActionMailer::Base

  def confirm(contact)
   	@contact_email = AppSetting.find(:first,
	   :conditions => " name = 'contact_email' ")
  
    @subject    = "Customer contact received"
    @recipients = @contact_email.value
    @from		= contact.email
    @body["contact"] = contact
  end
  
end
