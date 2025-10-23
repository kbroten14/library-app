class User < ApplicationRecord
  def available_books
    Book.where.not(id: CustomerBook.select(:book_id).where(status: 'borrowed'))
  end
end
