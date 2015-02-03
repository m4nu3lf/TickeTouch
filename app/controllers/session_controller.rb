class SessionController < ApplicationController
  def login
    if request.post?
      user = User.authenticate(params[:username], params[:password])
      if user then
        session[:user_id] = user.id
        url = session[:original_url]
        session[:original_url] = nil
        redirect_to(url || { :controller => :home, :action => :index })
      else
        flash.now[:notice] = "Invalid user/password combination"
      end
    end
  end

  def logout
    session[:user_id] = nil
    flash[:notice] =  "Logged out"
    redirect_to "/"
  end

  def index
  end

  def forbidden
    #TODO write a proper view for forbidden pages
    render :status => :forbidden
  end

end
