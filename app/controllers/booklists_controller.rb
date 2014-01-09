class BooklistsController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy
  def create
    @booklist = current_user.booklists.build(booklist_params)
    if @booklist.save
      flash[:success] = "Booklist created!"
      redirect_to @booklist
    end
  end

  def show
    @booklist = Booklist.find(params[:id])
  end

  def destroy
    @booklist.destroy
    redirect_to @current_user
  end

  private

    def booklist_params
      params.require(:booklist).permit(:title)
    end
end
