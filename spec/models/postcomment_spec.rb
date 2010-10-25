require 'spec_helper'

describe Postcomment do
 before(:each) do
    @attr = { :website => "http://www.decoratedworld.com",
  :name => "Paul",
  :content => "My comment content",
  :approved => true,
  :website => "www.google.com"}
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
  
  it "should make website links without leading http valid" do
    comment_with_website_without_http_at_start = Postcomment.new(@attr)
	comment_with_website_without_http_at_start.save
	comment_with_website_without_http_at_start.website.should == "http://www.google.com"
	
  end
  
  it "should leave valid web addresses as they are" do
    comment_with_website_with_http_at_start = Postcomment.new(@attr.merge(:website => "http://www.google.com"))
	comment_with_website_with_http_at_start.save
	comment_with_website_with_http_at_start.website.should == "http://www.google.com"
  end
  
  it "should leave valid SSL web addresses as they are" do
    comment_with_website_with_https_at_start = Postcomment.new(@attr.merge(:website => "https://www.google.com"))
	comment_with_website_with_https_at_start.save
	comment_with_website_with_https_at_start.website.should == "https://www.google.com"
  end
  
  it "blank web addresses should stay as they are" do
    comment_with_website_with_https_at_start = Postcomment.new(@attr.merge(:website => ""))
	comment_with_website_with_https_at_start.save
	comment_with_website_with_https_at_start.website.should == ""
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
