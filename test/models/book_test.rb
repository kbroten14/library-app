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
  end
end
        