class AddBookCountToAuthors < ActiveRecord::Migration[7.0]
  def change
    add_column :authors, :book_count, :integer
  end
end
