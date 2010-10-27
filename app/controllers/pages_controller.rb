class PagesController < ApplicationController
  def home
	@blogposts = Post.where(:published => true).limit(2)
	@title = "Home"
  end

  def contact
	@title = "Contact"
  end
  
  def services 
	@title = "Services"
  end
  

end
