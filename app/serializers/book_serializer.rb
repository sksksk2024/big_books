class BookSerializer < ActiveModel::Serializer
  attributes :book_name
  
  def author
    # Logic to retrieve author information for the book
  end
end
