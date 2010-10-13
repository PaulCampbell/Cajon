require 'spec_helper'

describe "PostsLinks" do
  
  describe "when viewing own posts" do
  
    before(:each) do
	  @user = Factory(:user)
	  visit signin_path
	  fill_in :email, :with => @user.email
	  fill_in :password, :with => @user.password 
	  click_button
	  @post = Factory(:post, :user => @user)	  
	end
  
    it "should have an edit link" do
	  visit post_path(@post)
	  response.should have_selector("a", :content => "Edit")
	end
	
  end
  
  describe "when viewing other's posts" do
  
    before(:each) do
        @user = Factory(:user)
        wrong_user = Factory(:user, :email => Factory.next(:email))
        visit signin_path
	    fill_in :email, :with => wrong_user.email
	    fill_in :password, :with => wrong_user.password 
	    click_button
		@post = Factory(:post, :user => @user)
      end
	  
	  
	  it "should not have an edit link" do
	    visit post_path(@post)
		response.should_not have_selector("a", :content => "Edit")
	  end
  
  end
  
  describe "when unauthenticated user views post" do
  
    before(:each) do
        @user = Factory(:user)
		@post = Factory(:post, :user => @user)
      end
    
	it "should not have an edit link" do
	  visit post_path(@post)
	  response.should_not have_selector("a", :content => "Edit")
	end
  
  end
  
end
