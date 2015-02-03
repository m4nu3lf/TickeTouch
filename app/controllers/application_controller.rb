class ApplicationController < ActionController::Base

  #session :session_key => '_depot_session_id'

  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store

  protect_from_forgery :secret => '8c3e099237e6366fd2f5366e9c430e79'

  # See ActionController::Base for details
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password")...*TRUNC*
  # filter_parameter_logging :password

  helper_method :current_user
  helper_method :is_admin

  def current_user
    if session[:user_id]
      return User.find(session[:user_id])
    end

    nil
  end

  def is_admin
    current_user and current_user.admin?
  end

  protected

  def check_user_logged
    unless User.find_by_id(session[:user_id])
      session[:original_url] = request.url
      flash[:notice] = "Please log in"
      redirect_to :controller => :session, :action => :login
    end
  end

  def check_admin_logged
    unless User.find(session[:user_id]).admin?
      redirect_to :controller => :session, :action => :forbidden
    end
  end
end
