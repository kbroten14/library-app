require 'csv'

class Book < ApplicationRecord
  has_many :customer_books, -> { order(created_at: :desc) }, dependent: :destroy
  has_many :customers, -> { order(created_at: :desc) }, through: :customer_books
  
  RETURNED_STATUS = 'returned'
  CHECKED_OUT_STATUS = 'checked out'
  AVAILABLE_STATUS = 'available'

  def self.available_books
    Book.where.not(id: CustomerBook.select(:book_id).where(status: CHECKED_OUT_STATUS))
  end

  def self.return_book(book_id, customer_id)
    customer_book = CustomerBook.find_by(book_id: book_id, customer_id: customer_id)

    return { success: false, message: "Customer does not have that book." } unless customer_book

    customer_book.status = RETURNED_STATUS
    
    if customer_book.save
      return { success: true, message: "Book has been marked as returned." }
    else
      return { success: false, message: "Book could not be marked as returned." }
    end
  end

  def self.checkout_book(book_id, customer_id)
    @customer = Customer.find_customer(customer_id)
    book = CustomerBook.find_or_initialize_by(book_id: book_id, customer_id: customer_id)
    book.status = CHECKED_OUT_STATUS

    if book.save
      return { success: true, message: "Book has been checked out." }
    else
      return { success: false, message: "Book could not be checked out." }
    end
  end

  def self.import(file)
    CSV.foreach(file.path, headers: :true) do |row|
      book = Book.find_or_initialize_by(isbn: row["isbn"])
      book.update(row.to_hash)
    end 
  end

  def self.export_all
    headers = %w{isbn title author category type rentee status last_activity_at}

    CSV.generate(headers: true) do |csv|
      csv << headers

      Book.find_each do |book|
        cb = book.customer_books&.first
        status = cb&.status || AVAILABLE_STATUS
        last_activity_at = cb&.updated_at || ''
        customer = cb&.customer
        rentee = customer ? "#{customer.first_name} #{customer.last_name}" : ''

        row = [
          book.isbn,
          book.title,
          book.author,
          book.category,
          book.type,
          rentee,
          status,
          last_activity_at
        ]

        csv << row
      end
    end
  end

  def self.order_by_latest
    Book.order("created_at DESC")
  end
end