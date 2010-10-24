require 'vendor/reversemarkdown/reverse_markdown'

class PostsController < ApplicationController
  before_filter :authenticate, :only => [:new, :create]
  before_filter :correct_user, :only => [:edit, :update, :destroy, :index]

  # GET users/1/posts
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.paginate(:page => params[:page], :per_page => 20)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.xml
  def show
	
    @post = Post.find(params[:id])
	@title = @post.title
	@postcomment = @post.postcomments.new

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @post }
    end
  end
  

  # GET /posts/new
  # GET /posts/new.xml
  def new
    @post = Post.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
	r = ReverseMarkdown.new
	content = r.parse_string(@post.content)
	@post.content = content
  end

  # POST /posts
  # POST /posts.xml
  def create
    @post = current_user.posts.build(params[:post])

    respond_to do |format|
      if @post.save
        format.html { redirect_to(@post, :notice => 'Post created.') }
        format.xml  { render :xml => @post, :status => :created, :location => @post }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.xml
  def update
    @post = Post.find(params[:id])
	published = false
	if  params[:post][:published] == 1
	  published = true
	end

    respond_to do |format|
      if @post.update_attributes(params[:post] )
        format.html { redirect_to(@post, :notice => 'Post updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.xml
  def destroy
	@post = Post.find(params[:id])
    @post.destroy
    flash[:success] = "Post deleted"
    respond_to do |format|
      format.html { redirect_to(user_posts_path(@post.user)) }
      format.xml  { head :ok }
    end
  end
  
  def publish
	@post = Post.find(params[:id])
	@post.published = true
	@post.save
	
	redirect_to(user_posts_path @post.user, :status => "Post published")
	
  end
  
  private 
	def correct_user
	  if params[:user_id].nil?
		@post = Post.find(params[:id])
        @user = @post.user
        is_correct_user(@user.id)
	  else
	    is_correct_user(params[:user_id])
	  end
    end
  
end
