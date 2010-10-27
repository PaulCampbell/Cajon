require 'spec_helper'

describe "ViewUserPageItems" do


    describe "GET /user/[id]" do

		describe "when user has twitter id" do
			
			before(:each) do
				@user  = Factory(:user, :twitter_name => "Slarty_Bartfast")
				get user_path @user
			end
			
			it "should have a twitter feed div" do
				response.should have_selector("div", :id => "twitter")
			end
		
		end
		
		
		describe "when user has no twitter id" do
		
			it "should not have a twitter feed div" do
				@user  = Factory(:user)
				get user_path @user
				response.should_not have_selector("div", :id => "twitter")
			end
		
		end
  end
  end

