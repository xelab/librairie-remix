class BooksController < ApplicationController
  def index
    @books = Book.all
    @publishers = Publisher.all
    @authors = Author.all
    @tags = Tag.all
  end

  def show
    @book = Book.find(params[:id])
    respond_to :json
  end

  def update
  end

  def create
    @book = Book.new(book_params)
    # binding.pry
    unless @book.price.present?
      @book.price = 0
    end 
    if @book.save
      render json: @book.id
    end
  end

  def destroy
  end

  def new
  end

  private
    def book_params
      params.require(:book).permit(:title, :price, :summary, :isbn, 
                                   :release, :buy, :deposit, :distributor_id, 
                                   :publisher_id, :collection_id, author_ids: [],
                                   tag_ids: [])
    end
end
