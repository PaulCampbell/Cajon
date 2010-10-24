require 'spec_helper'

describe Postcomment do
 before(:each) do
    @attr = { :website => "http://www.decoratedworld.com",
  :name => "Paul",
  :content => "My comment content",
  :approved => true}
  end

  it "should create a new instance given valid attributes" do
    Postcomment.create!(@attr)
  end

  it "should require content" do
    no_content_comment = Postcomment.new(@attr.merge(:content => ""))
    no_content_comment.should_not be_valid
  end
  
  it "should not allow content to be too long" do
    too_long_content_comment = Postcomment.new(@attr.merge(:content => "a" * 501))
    too_long_content_comment.should_not be_valid
  end
  
  
  it "should return friendly value if name is empty" do
	no_name_comment = Postcomment.new(@attr.merge(:name => ""))
	no_name_comment.friendly_name.should == "Anonymous"
  end
  
  it "should return name if name is not empty" do
	no_name_comment = Postcomment.new(@attr)
	no_name_comment.friendly_name.should == "Paul"
  end
  
  
  
  describe "post associations" do
     
    before(:each) do
	  @post = Factory(:post)
      @postcomment = @post.postcomments.create(@attr)
    end
    
    it "should have a post attribute" do
      @post.should respond_to(:user)
    end
    
    it "should have the correct post associated" do
      @postcomment.post_id.should == @post.id
      @postcomment.post.should == @post
    end
    
  end

  
end
