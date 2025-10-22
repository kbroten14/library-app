class CustomerBook < ApplicationRecord
  belongs_to :customer, optional: true
  belongs_to :book, optional: true
  
  def self.find_customers_books(book, customer)
    CustomerBook.where(["book_id = ? and customer_id = ?", book, customer]).first
  end
end