class UsersController < ApplicationController
  before_action :require_user,only:[:edit,:update]
  before_action :require_same_user,only:[:edit,:update,:destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.new(params.require(:users).permit(:username,:email,:password,:avatar))
    if @user.save
      session[:user_id] = @user.id
      flash[:notice]  = "Hello #{@user.username} !!!"
      redirect_to user_path(@user)
    else
      redirect_to '/signup'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(params.require(:user).permit(:username,:email,:password,:avatar))
      flash[:notice] = "Your Profile was Updated Successfully"
      redirect_to user_path(@user)
    else
      redirect_to '/edit'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def index
    @users = User.paginate(page:params[:page],per_page:3)
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    session[:user_id] = nil if !current_user.admin
    flash[:notice] = "Account and the Associated Articles are Deleted"
    redirect_to root_path
  end

  private

  def require_same_user
    @user = User.find(params[:id])
    if current_user != @user && !current_user.admin
      flash[:notice] = "You can Only Edit Your Profile"
      redirect_to @user
    end
  end

end
