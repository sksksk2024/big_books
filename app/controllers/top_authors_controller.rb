class TopAuthorsController < ApplicationController
  before_action :check_user_signed_in, only: [:index]

  def index
    current_month = Date.current.month
  
    # Fetch all authors
    @authors = Author.all
  
    if @authors.present?
      # Initialize the array with all authors and set book_count to 0
      @authors_with_book_counts = @authors.map do |author|
        {
          "id" => author.id,
          "name" => author.name,
          "book_count" => author.books.count
        }
      end
  
      # Sort authors by the number of books
      @authors_sorted_by_books = @authors_with_book_counts.sort_by { |author| -author["book_count"] }
    else
      # Handle the case where no authors are found
      flash.now[:alert] = "No authors found."
    end
  end
  
  private

  def check_user_signed_in
    unless user_signed_in?
      # Redirect the user to the sign-in page
      redirect_to new_user_session_path
    end
  end
end
