class BooksController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def create
    @book = current_user.books.build(book_params)
    if @book.save
      flash[:success] = "Book created!"
      redirect_to :back
    else
      @user  = current_user.reload
      render 'users/show'
    end
  end

  def destroy
    @book.destroy
    redirect_to current_user
  end

  private

    def book_params
      params.require(:book).permit(:title, :author)
    end

    def correct_user
      @book = current_user.books.find_by(id: params[:id])
      redirect_to user_path(current_user) if @book.nil?
    end
end
