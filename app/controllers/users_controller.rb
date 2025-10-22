class UsersController < ApplicationController
  def customer
    @customers = Customer.all
  end
  
  def list
    @customers = Customer.all
  end
  
  def show
    @customer = Customer.find_customer(params[:id])
    @customer_books = @customer.customer_books
  end
end
