class BooksController < ApplicationController
  def new
  end
  
  def list
    @customer = Customer.find_customer(params[:customer_id])
    @customer_books = @customer.customer_books
  end
  
  def returned
    @customer = Customer.find_customer(params[:customer_id])
    book = CustomerBook.find_customers_books(params[:id], params[:customer_id])
    book.status = 'returned'
    
    if book.save
      flash[:success] = "Book has been marked as returned."
    else
      flash[:error] = "Book could not be marked as returned."
    end
    
    redirect_back(fallback_location: customer_users_path)
  end

  def import
    Book.import(params[:file])
    redirect_to books_path, notice: "New Books Added!"
  end

  def export
    csv = Book.export_all
    filename = "books-#{Date.today}.csv"
    bom = "\uFEFF"
    send_data bom + csv, filename: filename, type: 'text/csv; charset=utf-8', disposition: 'attachment'
  end

  def index
    @books = Book.order_by_latest
  end
end
