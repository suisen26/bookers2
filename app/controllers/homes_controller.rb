class HomesController < ApplicationController
  def top
  end
  
  def index
    @user = current_user
    @users = User.all
    @book = Book.new
    @books = Book.all
    @book.user_id = current_user.id
  end

end
