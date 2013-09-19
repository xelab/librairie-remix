class BooksController < ApplicationController
  def index
    @books = Book.all
    @collections = Collection.all
    @publishers = Publisher.all
  end

  def update
  end

  def create
  end

  def destroy
  end

  def new
  end
end
