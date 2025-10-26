class BooksController < ApplicationController
  def new
  end
  
  def list
    @customer = Customer.find_customer(params[:customer_id])
    @customer_books = @customer.customer_books
  end
  
  def returned
    result = Book.return_book(params[:id])

    if result[:success]
      flash[:success] = result[:message]
    else
      flash[:error] = result[:message]
    end

    # currently can't trigger refresh without duplicating page
    # requires manual refresh to see changes
  end

  def checkout
    result = Book.checkout_book(params[:book_id], params[:customer_id])

    if result[:success]
      flash[:success] = result[:message]
    else
      flash[:error] = result[:message]
    end

    # currently can't trigger refresh without duplicating page
    # requires manual refresh to see changes
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
