class CreateUsers < ActiveRecord::Migration[7.2]
  def up
    create_table :users, :force => true do |t|
      t.column :type, :string, limit: 10
      t.column :first_name, :string, limit: 50
      t.column :last_name, :string, limit: 50
      t.timestamps
    end
  end

  def down
    drop_table :users
  end
end
