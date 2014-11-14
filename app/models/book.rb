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
    raw_data_books = Unirest.get("http://localhost:3000/books.json").body
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
    Book.new(Unirest.get("http://localhost:3000/books/#{id}.json").body)
  end

  def self.all
    books = []
    raw_data_books = Unirest.get("http://localhost:3000/books.json").body
    raw_data_books.each do |book_hash|
      books << Book.new(book_hash)
    end
    books
  end

  def self.destroy

  end

end
