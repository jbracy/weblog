class BlogsController < ApplicationController
  skip_before_filter :authorize
  
  # GET /blogs
  # GET /blogs.json
  def index
    @blogs = current_user.blogs

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @blogs }
    end
  end

  # GET /blogs/1
  # GET /blogs/1.json
  def show
    if current_user != nil
      @blog = current_user.blogs.find(params[:id])
    else
      user = User.find_by_id(params[:user_id])
      @blog = user.blogs.find(params[:id])
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @blog }
    end
  end

  # GET /blogs/new
  # GET /blogs/new.json
  def new
    @blog = Blog.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @blog }
    end
  end

  # GET /blogs/1/edit
  def edit
    @blog = current_user.blogs.find(params[:id])
  end

  # POST /blogs
  # POST /blogs.json
  def create
    @blog = current_user.blogs.build(params[:blog])

    respond_to do |format|
      if @blog.save
        format.html { redirect_to @blog, notice: 'Blog was successfully created.' }
        format.json { render json: @blog, status: :created, location: @blog }
      else
        format.html { render action: "new" }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /blogs/1
  # PUT /blogs/1.json
  def update
    @blog = current_user.blogs.find(params[:id])

    respond_to do |format|
      if @blog.update_attributes(params[:blog])
        format.html { redirect_to @blog, notice: 'Blog was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /blogs/1
  # DELETE /blogs/1.json
  def destroy
    @blog = current_user.blogs.find(params[:id])
    @blog.destroy

    respond_to do |format|
      format.html { redirect_to blogs_url }
      format.json { head :ok }
    end
  end
  
  def send_contact
    if params[:nametext] == "" or params[:emailtext] == "" or params[:messagetext] == ""
      flash[:error] = "Please Fill in all required Information(*)"
      render :action => 'contact'
    elsif (params[:emailtext] =~ /^[A-Z0-9_\.%\+\-\']+@(?:[A-Z0-9\-]+\.)+(?:[A-Z]{2,4}|museum|travel)$/i) == nil
      flash[:error] = "Please enter a valid email address"
      render :action => 'contact'
    else
      ContactMailer.inquiry(params).deliver
      flash[:notice] = "Email was successfully sent"
      redirect_to '/'
    end
  end
end