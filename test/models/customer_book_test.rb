require "test_helper"

class CustomerBookTest < ActiveSupport::TestCase
  context "methods" do
    context "find_customers books" do
      should "return the customer book record" do
        customer = create(:customer)
        customer_book = create(:customer_book, customer_id: customer.id, book_id: create(:book).id)

        assert_equal customer_book, CustomerBook.find_customers_books(customer_book.book_id, customer.id)
      end
    end
  end
end