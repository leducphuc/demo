class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create,:destroy]
  before_action :correct_user,only: :destroy
  def correct_user
    @micropost = current_user.microposts.find(params[:id])
    redirect_to root_url if @micropost.nil?
  end
  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success]="Micropost created!"
      redirect_to root_url
    else
      flash[:danger]="Micropost failed!"
      redirect_to root_url
    end
  end
  def destroy
    @micropost.destroy
    flash[:success] = "Micropost deleted"
    redirect_to request.referrer||root_url
  end
  private
  def micropost_params
    params.require(:micropost).permit(:content)
  end
end
