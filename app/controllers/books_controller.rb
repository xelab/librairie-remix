class BooksController < ApplicationController
  def index
    @books = Book.all
    @collections = Collection.all
    @publishers = Publisher.all
    @authors = Author.all
  end

  def show
    @book = Book.find(params[:id])
    respond_to :json
  end

  def update
  end

  def create
    @book = Book.create(params[:book])
    unless @book.price.present?
      @book.price = 0
    end  
    render json: @book.id
  end

  def destroy
  end

  def new
  end
end
