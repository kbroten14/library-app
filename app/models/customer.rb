class Customer < User
  has_many :customer_books, -> { order(created_at: :desc) }, dependent: :destroy
  has_many :books, -> { order(created_at: :desc) }, through: :customer_books
  has_many :audio_books, -> { where(type: "AudioBook") }, through: :customer_books, source: :book
  has_many :physical_books, -> { where(type: "PhysicalBook") }, through: :customer_books, source: :book
  
    def self.find_customer(customer)
      Customer.where(["id = ?", customer]).first
    end
end
  