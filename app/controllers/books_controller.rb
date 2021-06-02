class BooksController < ApplicationController
  def top
  end
  
  def show
    @book = Book.find(params[:id])
  end
  
  # 一覧画面（含、新規作成）
  def index
    @book = Book.new
    @books = Book.all
  end
  
  # book_paramsの定義はprivate内で行っている
  def create
    @book = Book.new(book_params)
    if @book.save
    flash[:notice] = "Book was successfully created."
    redirect_to book_path(@book)
    else
    # @book=Book.allを入れることでindex画面が正しく表示される
    @books = Book.all
    render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    book = Book.find(params[:id])
    if book.update(book_params)
    flash[:notice] = "Book was successfully updated."
    redirect_to book_path
    else
    flash[:alert] = "error"
    redirect_to book_path
    end
  end

  def destroy
    book = Book.find(params[:id])
    if book.destroy
    flash[:notice] = "Book was successfully deleted"
    redirect_to books_path
    else
    flash[:alert] = "error"
    redirect_to books_path
    end
  end

  private
  def book_params
    params.require(:book).permit(:title, :body)
  end
end
