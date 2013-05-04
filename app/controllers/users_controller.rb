# encoding: UTF-8

class UsersController < ApplicationController
  before_filter :require_user, :except => ["login", "do_login", "logout"]

  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end

  def new
    @user = User.new

    @types = UserType.all.map {|type| [type.nombre, type.id]}

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  def edit
    @user = User.find(params[:id])
    @types = UserType.all.map {|type| [type.nombre, type.id]}
  end

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

    @demo = !!params[:demo]

    render :layout => 'login'
  end

  def do_login
    mail = params[:mail]
    pass = params[:pass]

    user = User.find_all_by_mail_and_pass(mail, pass).first
    if user == nil
      if params[:from] != nil
        redirect_to("/login?from="+params[:from], :notice => 'Error iniciando sesión')
      else
        redirect_to("/login", :notice => 'Error iniciando sesión')
      end
    else
      self.current_user = user
      
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
