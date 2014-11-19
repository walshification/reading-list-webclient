class BooksController < ApplicationController

  def show
    @book = Book.find(params[:id])
  end

  def index
    @books = Book.all
  end

  def edit
    @book = Unirest.get("#{ENV['READING_LIST_API_ROOT']}/books.json", headers:{ "Content-Type" => "application/json", "X-User-Email" => "#{ENV['WEBCLIENT_EMAIL']}", "Authorization" => "Token token=#{ENV['WEBCLIENT_API_KEY']}" }).body
  end

  def update
    @book = Unirest.patch("#{ENV['READING_LIST_API_ROOT']}/books.json", headers:{ "Accept" => "application/json", "X-User-Email" => "#{ENV['WEBCLIENT_EMAIL']}", "Authorization" => "Token token=#{ENV['WEBCLIENT_API_KEY']}" },
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
