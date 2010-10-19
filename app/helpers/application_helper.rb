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
	
	def format_date(date, use_time = false)
    if use_time == true
        ampm = date.strftime("%p").downcase
        new_date = date.strftime("%B %d, %Y at %I:%M" + ampm)
    else
        new_date = date.strftime("%B %d, %Y")
    end
end

end
