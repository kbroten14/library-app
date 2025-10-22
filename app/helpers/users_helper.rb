module UsersHelper
  include ApplicationHelper
  
  def book_count(customer)
    books = CustomerBook.where("customer_id = #{customer.id}")
    books.size
  end

  def physical_books(customer)
    customer.books.where(["type = ?", "PhysicalBook"]).count
  end

  def audio_books(customer)
    customer.books.where(["type = ?", "AudioBook"]).count
  end
end
