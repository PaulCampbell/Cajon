module ApplicationHelper
	# Return a title for a page
	def title 
		base_title = "Cajon Blog Engine"
		if @title.nil?
				base_title
			else
				"#{base_title} | #{@title}"
		end
	end

end
