class ContactEmail < ActionMailer::Base
  default :from => "paulgcampbell@gmail.com"

  def contact(name, email, phone, message, sent_at = Time.now)
      @subject = "Decorated World - Contact"
      @recipients = "paulgcampbell@gmail.com"
      @from = email
      @sent_on = sent_at
	    @body["name"] = name
  	  @body["email"] = email
      @body["phone"] = phone
   	  @body["message"] = message
      @headers = {}
  end

end
