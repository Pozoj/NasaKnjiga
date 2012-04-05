class SessionsController < ApplicationController
  before_filter :authenticate_user, :only => [:destroy, :show]
  
  def create
    if params[:user]
      if user = User.authenticate(params[:user][:email], params[:user][:password])
        session[:user] = user.id
      
        # Redirect back or to root.
        if session[:back_to]
          back_to = session[:back_to]
          session[:back_to] = nil
          redirect_to back_to
        else
          case user.kind.kind
          when "admin"
            redirect_to root_path
          else
            redirect_to books_path
          end
        end
      else
        flash[:error] = "Napačno uporabniško ime ali geslo."
        render :action => :new
      end
    else
      render :action => :new
    end
  end
  
  def destroy
    session[:user] = nil
    redirect_to root_path
  end
end