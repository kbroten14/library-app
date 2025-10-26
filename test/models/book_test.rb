require "test_helper"

class BookTest < ActiveSupport::TestCase
  context "methods" do
    context "#order_by_latest" do
      should "return books from newest to oldest" do

        book_one = create(:book)
        book_two = create(:book)
        book_three = create(:book)

        assert_equal book_three, Book.order_by_latest.first
      end
    end

    context "#export_all" do
      should "generate a CSV with correct headers and data" do
        customer = create(:customer, first_name: "John", last_name: "Doe")
        book = create(:book, isbn: "1234567890", title: "Test Book", author: "Author Name", category: "fiction", type: "PhysicalBook")
        create(:customer_book, book: book, customer: customer, status: Book::CHECKED_OUT_STATUS, updated_at: Time.current)

        csv = Book.export_all
        rows = CSV.parse(csv, headers: true)

        assert_equal %w{isbn title author category type rentee status last_activity_at}, rows.headers
        assert_equal 1, rows.size
        assert_equal "1234567890", rows[0]["isbn"]
        assert_equal "Test Book", rows[0]["title"]
        assert_equal "Author Name", rows[0]["author"]
        assert_equal "fiction", rows[0]["category"]
        assert_equal "PhysicalBook", rows[0]["type"]
        assert_equal "John Doe", rows[0]["rentee"]
        assert_equal Book::CHECKED_OUT_STATUS, rows[0]["status"]
        assert_not_nil rows[0]["last_activity_at"]
      end

      should "handle books with no customer_books" do
        create(:book, isbn: "1987654321", title: "Available Book", author: "Another Author", category: "fiction", type: "AudioBook")

        csv = Book.export_all
        rows = CSV.parse(csv, headers: true)

        assert_equal 1, rows.size
        assert_equal "1987654321", rows[0]["isbn"]
        assert_equal "Available Book", rows[0]["title"]
        assert_equal "Another Author", rows[0]["author"]
        assert_equal "fiction", rows[0]["category"]
        assert_equal "AudioBook", rows[0]["type"]
        assert_equal "", rows[0]["rentee"]
        assert_equal Book::AVAILABLE_STATUS, rows[0]["status"]
        assert_equal "", rows[0]["last_activity_at"]
      end

      should "handle books with no associated customer" do
        book = create(:book, isbn: "1122334455", title: "Orphaned Book")

        csv = Book.export_all
        rows = CSV.parse(csv, headers: true)

        assert_equal 1, rows.size
        assert_equal "1122334455", rows[0]["isbn"]
        assert_equal "Orphaned Book", rows[0]["title"]
        assert_equal "", rows[0]["rentee"]
        assert_equal Book::AVAILABLE_STATUS, rows[0]["status"]
        assert_not_nil rows[0]["last_activity_at"]
      end

      should "generate an empty CSV if there are no books" do
        csv = Book.export_all
        rows = CSV.parse(csv, headers: true)

        assert_equal %w{isbn title author category type rentee status last_activity_at}, rows.headers
        assert_equal 0, rows.size
      end
    end
  end
end
        