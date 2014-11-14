class BooksController < ApplicationController

  def show
    @book = Book.find(params[:id])
  end

  def index
    @books = Book.all
  end

  def edit
    @book = Unirest.get("http://localhost:3000/books/#{params[:id]}.json", headers:{ "Accept" => "application/json" }).body
  end

  def update
    @book = Unirest.patch("http://localhost:3000/books/#{params[:id]}.json", headers:{ "Accept" => "application/json" },
      parameters: { :book =>
                    {
                      :title => params[:title],
                      :published_year => [:published_year],
                      :status => [:status]
                    }
                  }
      ).body
  end
end
