class PostcommentsController < ApplicationController


    # POST /commentposts
	def create
		@post = Post.find(params[:post_id])
		@postcomment = @post.postcomments.build(params[:postcomment])

		if @postcomment.save
			redirect_to(@post, :notice => 'Comment added.')
		else
			render  "posts/show" 
		end
		
	end
	
	def removeapproval
		@postcomment = Postcomment.find(params[:id])
		@postcomment.approved = false
		
		@postcomment.save
		redirect_to(@postcomment.post, :notice => 'Comment removed.')
		
	end

end
