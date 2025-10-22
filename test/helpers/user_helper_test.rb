require "test_helper"

class UsersHelperTest < ActionView::TestCase
  context "methods" do
    context "#book_count" do
      should "it returns the count of all books" do
        customer = create(:customer)
        customer_books = create_list(:customer_book, 2, customer_id: customer.id)

        assert_equal customer_books.size, book_count(customer)
      end
    end
    
    context "#physical_books" do
      should "it returns the count of physical books" do
        customer = create(:customer)

        create(:customer_book, customer_id: customer.id, book_id: create(:audio_book).id)
        create(:customer_book, customer_id: customer.id, book_id: create(:audio_book).id)

        create(:customer_book, customer_id: customer.id, book_id: create(:physical_book).id)
        create(:customer_book, customer_id: customer.id, book_id: create(:physical_book).id)

        assert_equal 2, physical_books(customer)
      end
    end 

    context "#auidi_books" do
      should "it returns the count of audio books" do
        customer = create(:customer)

        create(:customer_book, customer_id: customer.id, book_id: create(:audio_book).id)
        create(:customer_book, customer_id: customer.id, book_id: create(:audio_book).id)

        create(:customer_book, customer_id: customer.id, book_id: create(:physical_book).id)
        create(:customer_book, customer_id: customer.id, book_id: create(:physical_book).id)

        assert_equal 2, audio_books(customer)
      end
    end 
  end
end