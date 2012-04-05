class PermissionsController < ApplicationController  
  def create
    @user = User.find params[:user_id]
    @user.permissions.destroy_all
    if @user.permissions.create_all(params[:permission])
      flash[:notice] = "Dovoljenja uspešno nastavljena za uporabnika #{@user}."
    else
      flash[:error] = "Napaka pri nastavljanju dovoljenj."
    end
    redirect_to user_path(@user)
  end
end