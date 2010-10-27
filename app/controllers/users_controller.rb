class UsersController < ApplicationController
  before_filter :authenticate, :only => [:edit, :update]
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :non_signed_in_user, :only => [:new , :create]
  before_filter :admin_user,   :only => :destroy
  

  # GET /users
  # GET /users.xml
  def index
    @users = User.paginate(:page => params[:users_page])
	@posts = Post.where(:published => true).paginate(:page => params[:posts_page], :per_page => 5)
	@title = "Blog"
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  # GET /users/1
  # GET /users/1.xml
  def show
    @user = User.find(params[:id])
	@posts = @user.posts.where(:published => true).paginate(:page => params[:page], :per_page => 5)
	@title = @user.name 
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/new 
  # GET /users/new.xml
  def new
    @title = "Create a new user"
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end 

  # GET /users/1/edit
  def edit
    @title = "Edit user"
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.xml
  def create
    @user = User.new(params[:user])
	
    respond_to do |format|
      if @user.save
	    sign_in @user 
		flash[:success] = "You're in"
        format.html { redirect_to(@user, :notice => 'User was successfully created.') }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
		@title = "Create a new user"
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end 

  # PUT /users/1
  # PUT /users/1.xml
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
	    flash[:success] = "Profile updated"
        format.html { redirect_to(@user) }
        format.xml  { head :ok }
      else
	    @title = "Edit user"
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user = User.find(params[:id])
    @user.destroy
	flash[:success] = "User deleted"

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end 
   
  private

   def correct_user
     is_correct_user(params[:id])
   end
	
	
end
