class Author

  attr_accessor :first_name, :last_name, :status

  def initialize(hash)
    @first_name = hash["first_name"]
    @last_name = hash["last_name"]
    @status = hash["status"]
  end

  def full_name
    "#{@first_name} #{@last_name}"
  end

end