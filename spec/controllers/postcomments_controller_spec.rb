require 'spec_helper'

describe PostcommentsController do

	render_views
  
	describe "POST 'create'" do
	
	 before(:each) do
	  @post = Factory(:post)
    end

		describe "failure" do
			
			before(:each) do
				@attr = { :content => "", :post => @post}
			end
			
			it "should not create a comment" do
				lambda do
					post :create, {:postcomment => @attr, :post_id => @post.id}
				end.should_not change(Postcomment, :count)
			end
			
		end
		
		describe "success" do
			
			before(:each) do
				@attr = { :content => "Here's the content", :post => @post }
			end
			
			it "should create a comment" do
				lambda do
					post :create, {:postcomment => @attr, :post_id => @post.id}
				end.should change(Postcomment, :count)
			end
			
		end

	end

end
