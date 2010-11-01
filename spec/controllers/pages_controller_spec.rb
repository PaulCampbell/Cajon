require 'spec_helper'

describe PagesController do

  render_views

  before(:each) do
	@base_title = "Decorated World"
    
  end

  describe "GET 'home'" do
    it "should be successful" do
      get 'home'
      response.should be_success
    end

    it "should have the right title" do
      get 'home'
      response.should have_selector("title",
                                    :content => @base_title + " | Web and mobile application development")
    end
  end

  describe "GET 'contact'" do
    it "should be successful" do
      get 'contact'
      response.should be_success
    end

    it "should have the right title" do
      get 'contact'
      response.should have_selector("title",
                                    :content => @base_title + " | Contact")
    end
  end

  describe "GET 'services'" do
    it "should be successful" do
      get 'services'
      response.should be_success
    end

    it "should have the right title" do
      get 'services'
      response.should have_selector("title",
                                    :content => @base_title + " | Services")
    end
  end
end