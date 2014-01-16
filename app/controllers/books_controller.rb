class BooksController < ApplicationController
  before_action :signed_in_user, only: [:create]

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

  private

    def book_params
      params.require(:book).permit(:title, :author)
    end
end
