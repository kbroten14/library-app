module UsersHelper
  include ApplicationHelper
  
  def total_book_count(customer)
    books = CustomerBook.where("customer_id = #{customer.id}")
    books.size
  end

  def current_checked_out_books(customer)
    books = CustomerBook.where("customer_id = #{customer.id} AND status = '#{Book::CHECKED_OUT_STATUS}'")
    books.size
  end

  def physical_books(customer)
    customer.books.where(["type = ?", "PhysicalBook"]).count
  end

  def audio_books(customer)
    customer.books.where(["type = ?", "AudioBook"]).count
  end
end
