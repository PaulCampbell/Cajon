require 'spec_helper'

describe "UsersLinks" do

  describe "when not signed in" do
  
    it "should not have delete links" do
	  get '/users'
	  response.should_not have_selector("a", :content => "Delete")
	end
  
  end
   
  describe "when admin user" do
    
      before(:each) do
        @user = Factory(:user)
        visit signin_path
	    fill_in :email, :with => @user.email
	    fill_in :password, :with => @user.password 
	    click_button
		@user.toggle!(:admin)
      end
  
    it "should have delete links" do
	  get '/users'
	  response.should have_selector("a", :content => "Delete")
	end
  
  end
  
  describe "when non admin user" do
  
	before(:each) do
	  @user = Factory(:user)
	  visit signin_path
	  fill_in :email, :with => @user.email
	  fill_in :password, :with => @user.password 
	  click_button
	end
	
	it "should not have delete links" do
	  get '/users'
	  response.should_not have_selector("a", :content => "Delete")
	end
  
  end
  
end
