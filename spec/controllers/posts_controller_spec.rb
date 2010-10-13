require 'spec_helper'

describe PostsController do
  
  render_views

  describe "access control for non signed in user" do

    it "should deny access to 'create'" do
      post :create
      response.should redirect_to(signin_path)
    end

    it "should deny access to 'destroy'" do
      delete :destroy, :id => 1
      response.should redirect_to(signin_path)
    end
  end
  
  
  
  describe "POST 'create'" do

    before(:each) do
      @user = test_sign_in(Factory(:user))
    end

    describe "failure" do

      before(:each) do
        @attr = { :content => "", :title => "" }
      end

      it "should not create a post" do
        lambda do
          post :create, :post => @attr
        end.should_not change(Post, :count)
      end

      it "should render the home page" do
        post :create, :post => @attr
        response.should render_template('new')
      end
    end

    describe "success" do

      before(:each) do
        @attr = { :content => "Lorem ipsum", :title => "Post Title" }
      end

      it "should create a post" do
        lambda do
          post :create, :post => @attr
        end.should change(Post, :count).by(1)
      end

      it "should redirect to the Post page" do
        post :create, :post => @attr
        response.should redirect_to(post_path(assigns(:post)))
      end

      it "should have a flash message" do
        post :create, :post => @attr
        flash[:notice].should =~ /Post created./i
      end
    end
	

	
  end
  
  describe "GET 'new'" do
  
  	describe "for unauthenticated user" do
	  it "should deny access" do
	    get :new
		response.should redirect_to(signin_path)
	  end
	
	end
  
  end
  
  
  
  describe "DELETE 'destroy'" do

    describe "for incorrect user" do

      before(:each) do
        @user = Factory(:user)
        wrong_user = Factory(:user, :email => Factory.next(:email))
        test_sign_in(wrong_user)
        @post = Factory(:post, :user => @user)
      end

      it "should deny access" do
        delete :destroy, :id => @post
        response.should redirect_to(root_path)
      end
    end

    describe "for the correct user" do

      before(:each) do
        @user = test_sign_in(Factory(:user))
        @post = Factory(:post, :user => @user)
      end

      it "should destroy the post" do
        lambda do 
          delete :destroy, :id => @post
        end.should change(Post, :count).by(-1)
      end
    end
  end
  
  
  describe "GET 'edit'" do
  
    describe "for the correct user" do 

      before(:each) do
        @user = Factory(:user)
        test_sign_in(@user)
		@post = Factory(:post, :user => @user)
      end
	
	  it "should be successful" do
        get :edit, :id => @user
        response.should be_success
      end
	
	end
	
	 describe "for the incorrect user" do 

      before(:each) do
        @user = Factory(:user)
        wrong_user = Factory(:user, :email => Factory.next(:email))
        test_sign_in(wrong_user)
		@post = Factory(:post, :user => @user)
      end
	  
	  it "should redirect to root" do
        get :edit, :id => @user
        response.should_not be_success
      end
	
	end
  
  end
  
  describe "PUT 'update'" do
    
	describe "for the correct user" do 

      before(:each) do
        @user = Factory(:user)
        test_sign_in(@user)
		@post = Factory(:post, :user => @user)
		@attr = { :title => "New title", :content => "New content" }
      end
	  
	  it "should update the post" do
	    put :update, :id => @post, :post => @attr
		@post.reload
		@post.title.should == @attr[:title]
		@post.content.should == @attr[:content]
	  end
	  
	  it "should redirect to the show post page" do
	    put :update, :id => @post, :post => @attr
		response.should redirect_to(post_path(@post))
	  end
	  
	end
   
  end
  
  
  describe "for incorrect user" do
  
    before(:each) do
        @user = Factory(:user)
        wrong_user = Factory(:user, :email => Factory.next(:email))
        test_sign_in(wrong_user)
        @post = Factory(:post, :user => @user)
	end
	
	it "should deny access" do
	  put :update, :id => @post, :post => @attr
		response.should redirect_to(root_path)
	end
  end
  
end