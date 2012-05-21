# -*- coding: utf-8 -*-

class ApplicationController < ActionController::Base
  protect_from_forgery

  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end

  def signed_in?
    !!current_user
  end

  def is_admin?
    current_user.user_type_id == 1
  end

  def store_location
    session[:return_to] = request.fullpath
  end

  helper_method :current_user, :signed_in?, :is_admin?, :store_location

  def current_user=(user)
    @current_user = user
    session[:user_id] = user.id
  end

  def do_logout
    session[:user_id] = nil
  end

  def require_user

    if !signed_in?
      #store_location
      redirect_to '/login?from='+request.fullpath, :notice => "Por favor inicia sesión antes de continuar."
    end
  end

  # def require_admin
  #   if !signed_in? or !is_admin?
  #     store_location
  #     redirect_to '/login'
  #   end
  # end
end
