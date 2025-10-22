require "test_helper"

class BooksControllerTest < ActionController::TestCase
  context "#list" do 
    should "render the correct template" do 
      customer = create(:customer)

      get :list, params: { customer_id: customer.id }

      assert_template :list
    end

    should "assign customer" do 
      customer = create(:customer)

      get :list, params: { customer_id: customer.id }

      assert assigns(:customer)
    end

    should "assign customer books" do 
      customer = create(:customer)
      book = create(:book)
      create(:customer_book, customer_id: customer.id, book_id: book.id)

      get :list, params: { id: book.id, customer_id: customer.id }

      assert assigns(:customer_books)
    end
  end

  context "#returned" do 
    context "when the customer successfully returns a book" do 
      should "mark the book as returned" do 
        customer = create(:customer)
        book = create(:book)
        customer_book = create(:customer_book, customer_id: customer.id, book_id: book.id, status: "checked out")

        request.env["HTTP_REFERER"] = list_books_path(customer_id: customer.id)
        post :returned, params: { id: book.id, customer_id: customer.id }

        customer_book.reload

        assert_equal "returned", customer_book.status
      end

      should "display a success flash message" do 
        customer = create(:customer)
        book = create(:book)
        customer_book = create(:customer_book, customer_id: customer.id, book_id: book.id, status: "checked out")

        request.env["HTTP_REFERER"] = list_books_path(customer_id: customer.id)
        post :returned, params: { id: book.id, customer_id: customer.id }

        assert_equal "Book has been marked as returned.", flash[:success]
      end
    end

    context "when the customer unsuccessfully returns a book" do 
      should "not mark the book as returned" do 
        customer = create(:customer)
        book = create(:book)
        customer_book = create(:customer_book, customer_id: customer.id, book_id: book.id, status: "checked out")

        CustomerBook.any_instance.expects(:save).returns(false)

        request.env["HTTP_REFERER"] = list_books_path(customer_id: customer.id)
        post :returned, params: { id: book.id, customer_id: customer.id }

        customer_book.reload

        assert_not_equal "returned", customer_book.status
      end

      should "display the correct error flassh message" do 
        customer = create(:customer)
        book = create(:book)
        customer_book = create(:customer_book, customer_id: customer.id, book_id: book.id, status: "checked out")

        CustomerBook.any_instance.expects(:save).returns(false)

        request.env["HTTP_REFERER"] = list_books_path(customer_id: customer.id)
        post :returned, params: { id: book.id, customer_id: customer.id }

        customer_book.reload

        assert_equal "Book could not be marked as returned.", flash[:error]
      end
    end

    should "redirect correctly" do 
      customer = create(:customer)
      book = create(:book)
      customer_book = create(:customer_book, customer_id: customer.id, book_id: book.id, status: "checked out")

      request.env["HTTP_REFERER"] = list_books_path(customer_id: customer.id)     
      post :returned, params: { id: book.id, customer_id: customer.id }

      assert_redirected_to list_books_path(customer_id: customer.id)     
    end
  end

  context "#new" do
    should "render the correct template" do
      create(:customer)

      get :new

      assert_template :new
    end
  end 

  context "#index" do
    should "render the correct template" do
      create(:customer)

      get :index

      assert_template :index
    end

    should "assign books" do
      create(:book)

      get :index

      assert assigns(:books)
    end
  end 
end
