class PagesController < ApplicationController
  def home
	@blogposts = Post.where(:published => true).limit(2)
	@title = "Web and mobile application development"
  end

  def contact
	@title = "Contact"
  end
  
  def services 
	@title = "Services"
  end

  def sendmail
	    name = params["name"]
	    email = params["email"]
      phone = params["phone"]
      message = params["message"]
      ContactEmail.deliver_contact(name,email, phone, message)
      return if request.xhr?
      flash[:success] = "Message sent."
      render(:contact)
  end
  

end
