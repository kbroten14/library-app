class CreateCustomerBooks < ActiveRecord::Migration[7.2]
  def up
    create_table :customer_books, :force => true do |t|
      t.column :customer_id, :integer
      t.column :book_id, :integer
      t.column :status, :string, limit: 15, default: 'checked out'
      t.timestamps
    end
  end

  def down
    drop_table :customer_books
  end
end
