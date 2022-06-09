class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:update]

  def show
    @user = User.find(params[:id])
    @users = User.all
    @books = @user.books
    @book = Book.new
  end

  def index
    @users = User.all
    @user = current_user
    @books = Book.all
    @book = Book.new
    
  end

  def edit
    @user=User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    else
      render :edit
    end
  end

  def update
    @user=User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  def ensure_correct_user
    @user = User.find(params[:id])

  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

end
