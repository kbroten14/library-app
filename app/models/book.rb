require 'csv'

class Book < ApplicationRecord
  has_many :customer_books, -> { order(created_at: :desc) }, dependent: :destroy
  has_many :customers, -> { order(created_at: :desc) }, through: :customer_books
    
  def self.import(file)
    CSV.foreach(file.path, headers: :true) do |row|
      book = Book.find_or_initialize_by(isbn: row["isbn"])
      book.update(row.to_hash)
    end 
  end

  def self.export_all
    headers = %w{isbn title author status rentee updated_at}

    CSV.generate(headers: true) do |csv|
      csv << headers

      Book.find_each do |book|
        cb = book.customer_books&.first
        status = cb&.status || 'available'
        customer = cb&.customer
        rentee = customer ? "#{customer.first_name} #{customer.last_name}" : ''

        row = [
          book.isbn,
          book.title,
          book.author,
          status,
          rentee,
          book.updated_at
        ]

        csv << row
      end
    end
  end

  def self.order_by_latest
    Book.order("created_at DESC")
  end
end