# frozen_string_literal: true

json.extract! book, :id, :book_name, :author_first_name, :author_last_name, :price, :created_at, :updated_at
json.url book_url(book, format: :json)
