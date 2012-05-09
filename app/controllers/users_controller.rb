class UsersController < ApplicationController
  # GET /users
  # GET /users.xml
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  # GET /users/1
  # GET /users/1.xml
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    @user = User.new

    @types = UserType.all.map {|type| [type.nombre, type.id]}

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
    @types = UserType.all.map {|type| [type.nombre, type.id]}
  end

  # POST /users
  # POST /users.xml
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to(@user, :notice => 'User was successfully created.') }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
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
        format.html { redirect_to(@user, :notice => 'User was successfully updated.') }
        format.xml  { head :ok }
      else
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

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end

  def login
    if params[:from] != nil
      session["return_to"] = params[:from] # doesnt save session (?)
      @from = params[:from]
    end

    render :layout => 'login'
  end

  def do_login
    mail = params[:mail]
    pass = params[:pass]

    user = User.find_all_by_mail_and_pass(mail, pass).first
    if user == nil
      redirect_to("/login", :notice => 'Error iniciando sesión')
    else
      self.current_user = user
      # if session["return_to"] != nil
      #   redirect_to(session["return_to"], :notice => 'Loged in')
      #   session["return_to"] = nil
      if params[:from] != nil
        redirect_to(params[:from], :notice => 'Loged in')
      else
        redirect_to("/", :notice => 'Loged in')
      end
    end

  end

  def logout
    self.do_logout
    redirect_to("/", :notice => 'Loged out')
  end
end
