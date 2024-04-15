class AddPublicationDateToBooks < ActiveRecord::Migration[7.0]
  def change
    add_column :books, :publication_date, :date
  end
end
