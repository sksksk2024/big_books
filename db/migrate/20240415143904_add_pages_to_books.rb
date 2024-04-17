# frozen_string_literal: true

class AddPagesToBooks < ActiveRecord::Migration[7.0]
  def change
    add_column :books, :page_number, :integer, limit: 3, default: 1, null: false
    change_column_default :books, :pages, from: nil, to: 1
    change_column :books, :page_number, :integer, limit: 3, null: false, default: 1
  end
end
