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
  

end
