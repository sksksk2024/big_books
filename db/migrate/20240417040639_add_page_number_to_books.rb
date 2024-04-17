class AddPageNumberToBooks < ActiveRecord::Migration[7.0]
  def change
    add_column :books, :page_number, :integer
  end
end
