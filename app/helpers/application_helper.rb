module ApplicationHelper
	# Return a title for a page
	def title 
		base_title = "Decorated World"
		if @title.nil?
				base_title
			else
				"#{base_title} | #{@title}"
		end
	end
	
	def format_date_short(date, use_time = false)
      if use_time == true
        ampm = date.strftime("%p").downcase
        new_date = date.strftime("%b %d at %I:%M" + ampm)
      else
        new_date = date.strftime("%b %d")
      end
	end
	
	def format_date_long(date, use_time = false)
		if use_time == false
		  date_long = date.strftime("%d %B %Y at %H:%M")
		else
		  date_long = date.strftime("%d %B %Y")
		end
	end
	

end
