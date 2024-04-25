class RemoveAuthorsNameFromBooks < ActiveRecord::Migration[7.0]
  def change
    remove_column :books, :author_first_name, :string
    remove_column :books, :author_last_name, :string
  end
end
