class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(params.require(:users).permit(:username,:email,:password,:avatar))
    if @user.save
      flash[:notice]  = "Hello #{@user.username} !!!"
      redirect_to articles_path
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
      redirect_to articles_path
    else
      redirect_to '/edit'
    end
  end

  def show
    @user = User.find(params[:id])
  end

end