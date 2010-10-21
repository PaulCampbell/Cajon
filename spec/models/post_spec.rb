require 'spec_helper'

describe Post do
  
  before(:each) do
    @user = Factory(:user)
    @attr = {
      :content => "here's the body of the post",
      :title => "The Post Title"
    }
  end
  
  it "should create a new instance given valid attributes" do
    @user.posts.create!(@attr)
  end
  
  describe "user associations" do
     
    before(:each) do
      @post = @user.posts.create(@attr)
    end
    
    it "should have a user attribute" do
      @post.should respond_to(:user)
    end
    
    it "should have the correct user associated" do
      @post.user_id.should == @user.id
      @post.user.should == @user
    end
    
  end
  
  describe "validations" do

    it "should require a user id" do
      Post.new(@attr).should_not be_valid
    end

    it "should require nonblank content" do
      @user.posts.build(:content => "  ").should_not be_valid
    end

    it "should reject long content" do
      @user.posts.build(:content => "a" * 3001).should_not be_valid
    end
	
	it "should require nonblank title" do
      @user.posts.build(:title => "  ").should_not be_valid
    end
	
	it "should reject long title" do
      @user.posts.build(:title => "a" * 201).should_not be_valid
    end
	
  end
  
  
  describe "comment associations" do
  
	before(:each) do
	  @post =  @user.posts.create!(@attr)
	  @postcomment1 = Factory(:postcomment, :post => @post, :created_at => 1.days.ago)
	  @postcomment2 = Factory(:postcomment, :post => @post, :created_at => 2.days.ago)
	end
	
	it "should have a postcomments attribute" do
	  @post.should respond_to(:postcomments)
	end
	
	it "should have the right postcomments in ascending date order" do
	  @post.postcomments.should == [@postcomment2, @postcomment1]
	end
	
	it "should destroy the post's postcomments" do
	  @post.destroy
	  [@postcomment1, @postcomment2].each do |postcomment|
	    Postcomment.find_by_id(postcomment.id).should be_nil
	  end
	end
  
  end

end