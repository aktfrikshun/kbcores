class Contact
  attr_reader  :first_name
  attr_reader  :last_name
  attr_reader  :title
  attr_reader  :company
  attr_reader  :address1
  attr_reader  :address2
  attr_reader  :city
  attr_reader  :state
  attr_reader  :zip_code
  attr_reader  :phone
  attr_reader  :email
  attr_reader  :comments
  attr_reader  :account_number
  
  def set_first_name(inVal)
    @first_name = inVal
  end
  def set_last_name(inVal)
    @last_name = inVal
  end
  def set_title(inVal)
    @title = inVal
  end
  def set_company(inVal)
    @company = inVal
  end
  def set_address1(inVal)
    @address1 = inVal
  end
  def set_address2(inVal)
    @address2 = inVal
  end
  def set_city(inVal)
    @city = inVal
  end
  def set_state(inVal)
    @state = inVal
  end
  def set_zip_code(inVal)
    @zip_code = inVal
  end
  def set_email(inVal)
    @email = inVal
  end
  def set_phone(inVal)
    @phone = inVal
  end
  def set_comments(inVal)
    @comments = inVal
  end
  def set_account_number(inVal)
  	@account_number = inVal
  end
  
  
  
end