class UsersController < ApplicationController
  before_action :logged_in_user,only:[:edit,:update,:index,:destroy,:following,:followers]
  before_action :correc_user,only:[:edit,:update]
  before_action :admin_user,only: :destroy
  def new
    @user = User.new
  end
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end
  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end
  def edit
    @user = User.find(params[:id])
  end
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end
  def show
    @user = User.find_by(id: params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end
  def index
    @users = User.all.paginate(page:params[:page])
  end
  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end
  def followers
    @title = "Follower"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end
  private
  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
  def user_params
    params.require(:user).permit(:name,:email,:password,:password_confirmation)
  end
  def correc_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless @user == current_user
  end
end
