class Book

  attr_accessor :title, :authors, :published_year, :blurb, :status

  def initialize(hash)
    @title = hash["title"]
    @authors = hash["authors"]
    @published_year = hash["published_year"]
    @blurb = hash["blurb"]
    @status = hash["status"]
  end

  def prioritize
    low = []
    high = []
    raw_data_books = Unirest.get("#{ENV["READING_LIST_API_ROOT"]}/books.json", headers:{ "Content-Type" => "application/json", "X-User-Email" => "#{ENV['WEBCLIENT_EMAIL']}", "Authorization" => "Token token=#{ENV['WEBCLIENT_API_KEY']}" }).body
    raw_data_books.each do |book_hash|
      books << Book.new(book_hash)
    end
    books.sort.each do |book|
      if book.status == "read"
        low << book
      else
        high << book
      end
    end
    books = high.concat(low)
  end

  def self.find(id)
    Book.new(Unirest.get("#{ENV["READING_LIST_API_ROOT"]}/books/#{id}.json").body, headers:{ "Content-Type" => "application/json", "X-User-Email" => "#{ENV['WEBCLIENT_EMAIL']}", "Authorization" => "Token token=#{ENV['WEBCLIENT_API_KEY']}" })
  end

  def self.all
    books = []
    raw_data_books = Unirest.get("#{ENV["READING_LIST_API_ROOT"]}/books.json", headers:{ "Content-Type" => "application/json", "X-User-Email" => "#{ENV['WEBCLIENT_EMAIL']}", "Authorization" => "Token token=#{ENV['WEBCLIENT_API_KEY']}" }).body
    raw_data_books.each do |book_hash|
      books << Book.new(book_hash)
    end
    books
  end

  def self.destroy

  end

end
