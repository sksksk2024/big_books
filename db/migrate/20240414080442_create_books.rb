# frozen_string_literal: true

class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books do |t|
      t.string :book_name
      t.string :author_first_name
      t.string :author_last_name
      t.integer :price

      t.timestamps
    end
  end
end
